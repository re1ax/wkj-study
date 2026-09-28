# -*- coding: ascii -*-
"""Preserve OR-of-conjunction initial groups through the shared translator.

The root of a ONEOF is represented by conditions.Conjunction in this parser;
its children are alternatives, not a conjunction to flatten. Only conjunctions
*inside* an alternative are flattened. Group and alternative order must agree
with the original PDDL consumed by the CEGIS renderer.
"""

import conditions


def conjunctive_literals(term):
    if isinstance(term, conditions.Literal):
        return [term]
    if isinstance(term, conditions.Conjunction) and term.parts:
        result = []
        for part in term.parts:
            result.extend(conjunctive_literals(part))
        return result
    raise ValueError("Initial uncertainty alternatives must be literals or "
                     "nonempty conjunctions of literals; got %s" %
                     term.__class__.__name__)


def validate_or_form(form):
    """Validate before parsing, which otherwise treats nested ONEOF as AND."""
    def check_term(term):
        if not isinstance(term, list) or not term:
            raise ValueError("Empty or malformed initial OR alternative")
        if term[0] == "and":
            if len(term) == 1:
                raise ValueError("Empty AND inside initial OR is unsupported")
            for part in term[1:]:
                check_term(part)
            return
        if term[0] == "not":
            if len(term) != 2:
                raise ValueError("Initial NOT must contain exactly one atom")
            term = term[1]
        if (not isinstance(term, list) or not term or
                term[0] in ("and", "or", "not", "oneof", "unknown",
                            "imply", "forall", "exists", "=") or
                any(isinstance(arg, list) for arg in term[1:])):
            raise ValueError("Initial OR supports literals and conjunctions "
                             "of literals, not nested alternatives/quantifiers")

    if len(form) < 2:
        raise ValueError("Empty initial OR is unsupported")
    for term in form[1:]:
        check_term(term)


def positive_support_atoms(groups):
    """Possible atoms for grounding, not assertions that every atom is true."""
    seen = set()
    result = []
    for group in groups:
        if not group.parts:
            raise ValueError("Empty initial uncertainty group is unsupported")
        for term in group.parts:
            for literal in conjunctive_literals(term):
                atom = literal.positive()
                if atom not in seen:
                    seen.add(atom)
                    result.append(atom)
    return result


def serialize_groups(translation_key, ors, oneofs):
    """Write the existing signed SAS format, with ',' terminating each term.

Use full fact names as keys, never substring matching of printed formulas.
Negative value encoding -(value + 1) matches CounterCNF/InitialConstraintIR.
Missing mappings are an error: dropping a literal would change the belief.
"""
    fact_map = {}
    for var, values in enumerate(translation_key):
        for value, name in enumerate(values):
            if name.startswith("Atom "):
                fact_map.setdefault(name, []).append((var, value))

    lines = []
    for kind, groups in (("OR", ors), ("ONEOF", oneofs)):
        lines.extend([kind, str(len(groups))])
        for group in groups:
            if not group.parts:
                raise ValueError("Empty initial %s group is unsupported" % kind)
            for term in group.parts:
                for literal in conjunctive_literals(term):
                    name = str(literal.positive())
                    entries = fact_map.get(name, [])
                    if len(entries) != 1:
                        raise ValueError("Expected one SAS mapping for initial "
                                         "literal %s; found %d" %
                                         (literal, len(entries)))
                    var, value = entries[0]
                    if literal.negated:
                        value = -(value + 1)
                    lines.extend(["var%d" % var, str(value)])
                lines.append(",")
            lines.append("END_" + kind)
    return "\n".join(lines) + "\n"
