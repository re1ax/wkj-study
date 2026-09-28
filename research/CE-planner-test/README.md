# Conformant Planning via Counterexample-Guided Subproblem Reconstruction

## Overview

This package contains the implementation accompanying the paper *Conformant Planning via Counterexample-Guided Subproblem Reconstruction*.

The method reconstructs only the initial formula, generates a candidate plan with an existing conformant planner, verifies it against the original problem, and adds a counterexample when verification fails.

The core implementation is under `lama/`; the 12 planner configurations are launched through `plan-cegis-\*`.

The included `test/` directory contains small examples for installation and execution checks. The complete 1,179-instance benchmark suite is not included.

## Build and Quick Tests

Run the following commands from the extracted project directory:

```bash
bash ./build
./run-tests
./run-example.sh
```

`build` restores executable permissions, installs or checks dependencies, performs a clean build, and checks the installation. 

`run-tests` checks all 12 candidate-planner routes and the common final verifier using different short cases.

`run-example.sh` runs a short T1 example that exercises the counterexample-refinement loop.

Without SICStus, a successful matrix ends with:

```text
passes=8 failures=0 skips=4
```

With licensed SICStus available, the expected summary is:

```text
passes=12 failures=0 skips=0
```

The single CE example succeeds when the command exits with status 0 and its detailed log contains CE progress information and `final\_status=VALID`.

## Optional SICStus Routes

CNF, DNF, PIP, and CPA(H) require licensed SICStus Prolog 4.10.1; the other eight configurations do not.

The commercial installer is not included because it would make the submission exceed 50 MB and its redistribution terms must be respected.

During an interactive build, the installer can be downloaded from the official SICStus address and its SHA-256 checksum is verified before use.

Alternatively, place the downloaded archive in the project directory or select it explicitly:

```bash
SICSTUS\_ARCHIVE=/absolute/path/sp-4.10.1-x86\_64-linux-glibc2.28.tar.gz \\
  bash ./build
```

The vendor installer requests the reviewer's own valid license interactively.

For private non-interactive testing, set all three variables below only in the local shell:

```bash
export SICSTUS\_SITE\_NAME='...'
export SICSTUS\_LICENSE\_CODE='...'
export SICSTUS\_EXPIRATION\_DATE='YYYYMMDD'
bash ./build
```

If SICStus download, installation, or licensing fails, the build continues and the eight open configurations remain testable.

To skip SICStus explicitly, use:

```bash
SICSTUS\_SKIP=1 bash ./build
```

To require all 12 configurations, use:

```bash
./run-tests --require-all
```

## Configurations and Cases

The command names and retained quick cases are listed below.

|Paper configuration|Command|Quick case|Additional requirement|
|-|-|-|-|
|T0|`t0`|`bomb/p5-1`|—|
|T1|`t1`|`omlette/p3`|—|
|CFF|`cff`|`blocks/b2`|—|
|POND|`pond`|`safe/p5`|—|
|CNF|`cnf`|`or-coins/p10`|SICStus|
|DNF|`dnf`|`blocks/b3`|SICStus|
|PIP|`pip`|`or-coins/p15`|SICStus|
|CPA(H)|`cpah`|`bomb/p10-1`|SICStus|
|iGC|`igc`|`safe/p10`|—|
|GC\[LAMA]|`gc-lama`|`blocks/b3`|—|
|gCPCES|`gcpces`|`safe/p5`|—|
|iCPCES|`icpces`|`blocks/b3`|—|

To run a selected route and case, use:

```bash
./run-example.sh <route> <domain/problem> <timeout-seconds>
```

For example:

```bash
./run-example.sh pond safe/p5 120
```

## Output

Validated plans are written under `result\_output\_batch\_ce/`, detailed logs under `test\_logs\_ce/`, and temporary iteration workspaces under `runs/`.

`VALID` means that the final plan passed the common conformant-plan verifier, not merely that a planner process started.

## Opt-in OR of AND Initial States

The original PDDL translator remains the default. To allow an initial
disjunction whose alternatives are conjunctions of literals, enable the
alternate translation path for one invocation:

```bash
CE_PLANNER_OR_AND_INIT=1 ./plan-cegis-cff domain.pddl problem.pddl result.plan false
```

This path also accepts `(:init (and (or ...) (or ...)))`. It exposes the
conjunctive clauses to the translator, then distributes each `or` containing
`and` alternatives into flat CNF clauses. For example,
`(or (and a b) (and c d))` becomes four clauses: `(or a c)`, `(or a d)`,
`(or b c)`, and `(or b d)`. Positive and negative literals are preserved in
`oneof_initial`. The conversion represents every satisfying initial assignment
without listing assignments individually. Clause count can grow exponentially
with the number and size of alternatives. It does not change the candidate
planner's search behavior or guarantee that CFF will find a conformant plan.

The same variable can prefix `./run-example.sh cff blocks/b2 120` after
editing the selected problem file. To make this the default for a local
launcher, add `export CE_PLANNER_OR_AND_INIT=1` near the start of that
launcher. The switch is read by `lama/translate/or_and_init.py` and affects
the initial PDDL translation; the old path runs when the variable is absent.

Each `or` alternative may be a literal or an `and` of positive and negative
literals. A single-alternative `or` is equivalent to its alternative; for
example, `(or (and (handempty) (holding A)))` requires both facts at once.

The same opt-in path also preserves compound `oneof` groups as uncertainty
instead of treating their first branch as fixed facts. If exactly one starting
node and exactly one label assignment per node is intended, run the separate
`uts-cycle-oneof/p3` case:

```bash
CE_PLANNER_OR_AND_INIT=1 ./run-example.sh cff uts-cycle-oneof/p3 120
```

The `uts-cycle/p3` problem uses `or`, which permits several branches in a
group to hold simultaneously. The `oneof` case therefore has a narrower set
of initial states. In particular, `or` permits all three `at_node` facts to
hold at once. The former `uts-cycle/d3.pddl` action could add and delete the
same position in one step; its SAS effect order deleted all positions for
some valid initial states. That domain is preserved as
`uts-cycle/d3-original.pddl`. The current `uts-cycle/d3.pddl` guards each
delete when another active node reaches the same position, retaining the
usual moving-node behavior for a single starting position. With the original
`or` problem unchanged, the following command now yields a validated plan:

```bash
CE_PLANNER_OR_AND_INIT=1 ./run-example.sh cff uts-cycle/p3 120
```

## Common Problems

If `build` cannot install packages, check the network connection, `sudo` access, Ubuntu package sources, and free disk space, then rerun it.

Four `SKIP` results mean that SICStus is unavailable or its license was rejected or expired. This is expected and does not invalidate the other eight routes.

If a test times out, rerun that route with a larger timeout and inspect its log under `test\_logs\_ce/`.
