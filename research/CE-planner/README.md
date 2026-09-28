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

## Common Problems

If `build` cannot install packages, check the network connection, `sudo` access, Ubuntu package sources, and free disk space, then rerun it.

Four `SKIP` results mean that SICStus is unavailable or its license was rejected or expired. This is expected and does not invalidate the other eight routes.

If a test times out, rerun that route with a larger timeout and inspect its log under `test\_logs\_ce/`.

