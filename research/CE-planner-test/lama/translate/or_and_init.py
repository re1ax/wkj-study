"""Opt-in support for ORs whose alternatives are conjunctions of literals.

The legacy translator remains the default. Set CE_PLANNER_OR_AND_INIT=1 to
enable this module from the existing translator entry point.
"""

import os
import itertools


def enabled():
    return os.environ.get("CE_PLANNER_OR_AND_INIT") == "1"


def flatten_initial_conjunctions(forms):
    """Expose clauses wrapped in (:init (and ...)) to the legacy parser."""
    flattened = []
    for form in forms:
        if isinstance(form, list) and form and form[0] == "and":
            flattened.extend(flatten_initial_conjunctions(form[1:]))
        else:
            flattened.append(form)
    return flattened


def literals_in_alternative(condition):
    import pddl
    if isinstance(condition, pddl.Conjunction):
        result = []
        for part in condition.parts:
            result.extend(literals_in_alternative(part))
        return result
    if isinstance(condition, pddl.Literal):
        return [condition]
    raise ValueError("OR initial alternatives must contain only AND and literals: %s" %
                     condition.__class__.__name__)


def expand_or_conditions_to_cnf(ors):
    """Distribute each OR of AND alternatives into flat CNF clauses.

    (a AND b) OR (c AND d) becomes (a OR c), (a OR d),
    (b OR c), (b OR d). Each input OR is conjoined with the others.
    """
    import pddl
    clauses = []
    seen_clauses = set()
    for disjunction in ors:
        if not isinstance(disjunction, pddl.Disjunction) or not disjunction.parts:
            raise ValueError("initial OR must have at least one alternative")
        alternatives = [literals_in_alternative(part)
                        for part in disjunction.parts]
        if any(not alternative for alternative in alternatives):
            raise ValueError("empty AND alternative in initial OR")
        for selected in itertools.product(*alternatives):
            literals = []
            seen_literals = set()
            for literal in selected:
                key = (literal.predicate, literal.args, literal.negated)
                if key not in seen_literals:
                    seen_literals.add(key)
                    literals.append(literal)
            # Keep tautological clauses: their atoms still need grounding.
            key = frozenset(seen_literals)
            if key not in seen_clauses:
                seen_clauses.add(key)
                clauses.append(pddl.Disjunction(literals))
    return clauses


def possible_atoms(ors):
    import pddl
    for disjunction in ors:
        for alternative in disjunction.parts:
            for literal in literals_in_alternative(alternative):
                yield pddl.Atom(literal.predicate, literal.args)


def _render_or_prefix(translation_key, ors):
    import pddl
    mapping = {}
    for var_no, var_key in enumerate(translation_key):
        for value, value_name in enumerate(var_key):
            mapping.setdefault(value_name, []).append((var_no, value))

    lines = ["OR", str(len(ors))]
    for disjunction in ors:
        for alternative in disjunction.parts:
            literals = literals_in_alternative(alternative)
            if not literals:
                raise ValueError("empty AND alternative in initial OR")
            for literal in literals:
                atom_name = str(pddl.Atom(literal.predicate, literal.args))
                matches = mapping.get(atom_name, [])
                if len(matches) != 1:
                    raise ValueError("initial OR literal %s has %d SAS mappings (expected 1)" %
                                     (literal, len(matches)))
                var_no, value = matches[0]
                lines.extend(["var%d" % var_no,
                              str(value if not literal.negated else -value - 1)])
            lines.append(",")
        lines.append("END_OR")
    return "\n".join(lines) + "\n"


def rewrite_or_sections(translation_key, ors):
    """Replace only the legacy OR section, retaining its ONEOF section."""
    prefix = _render_or_prefix(translation_key, ors)
    for path in ("oneof", "oneof_initial"):
        with open(path) as source:
            original = source.read()
        marker = "ONEOF\n"
        offset = original.find(marker)
        if offset < 0:
            raise ValueError("legacy translator did not emit a ONEOF section in %s" % path)
        with open(path, "w") as target:
            target.write(prefix + original[offset:])
