"""Run with Python 2: python2 -m unittest discover -s lama/translate/tests."""

import itertools
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import or_and_init
import pddl
from pddl import conditions


def evaluate(condition, assignment):
    if isinstance(condition, pddl.Conjunction):
        return all(evaluate(part, assignment) for part in condition.parts)
    if isinstance(condition, pddl.Disjunction):
        return any(evaluate(part, assignment) for part in condition.parts)
    if isinstance(condition, pddl.Literal):
        value = assignment[(condition.predicate, condition.args)]
        return not value if condition.negated else value
    raise AssertionError(condition)


class OrAndCnfTests(unittest.TestCase):
    def assert_equivalent(self, raw_groups):
        original = [conditions.parse_condition(group) for group in raw_groups]
        clauses = or_and_init.expand_or_conditions_to_cnf(original)
        atoms = set((literal.predicate, literal.args)
                    for group in original for branch in group.parts
                    for literal in or_and_init.literals_in_alternative(branch))
        atoms = sorted(atoms)
        for values in itertools.product((False, True), repeat=len(atoms)):
            assignment = dict(zip(atoms, values))
            self.assertEqual(all(evaluate(group, assignment) for group in original),
                             all(evaluate(clause, assignment) for clause in clauses))
        for clause in clauses:
            self.assertTrue(all(isinstance(part, pddl.Literal)
                                for part in clause.parts))
        return clauses

    def test_distribution_and_shared_atoms(self):
        groups = [
            ["or", ["and", ["a"], ["b"]],
                   ["and", ["c"], ["d"]]],
            ["or", ["and", ["a"], ["not", ["b"]]],
                   ["and", ["not", ["a"]], ["d"]]],
        ]
        self.assertEqual(len(self.assert_equivalent(groups)), 7)

    def test_tautologies_and_duplicate_literals(self):
        groups = [["or", ["and", ["a"], ["not", ["a"]]],
                         ["and", ["b"], ["b"]]]]
        clauses = self.assert_equivalent(groups)
        self.assertEqual(len(clauses), 2)
        self.assertTrue(all(any(part.predicate == "b" for part in clause.parts)
                            for clause in clauses))

    def test_single_and_alternative(self):
        clauses = self.assert_equivalent(
            [["or", ["and", ["a"], ["not", ["b"]]]]])
        self.assertEqual(len(clauses), 2)
        self.assertTrue(all(len(clause.parts) == 1 for clause in clauses))

    def test_tautology_keeps_atom_for_grounding(self):
        clauses = self.assert_equivalent([["or", ["a"], ["not", ["a"]]]])
        self.assertEqual(len(clauses), 1)
        self.assertEqual(list(or_and_init.possible_atoms(clauses))[0].predicate,
                         "a")


if __name__ == "__main__":
    unittest.main()
