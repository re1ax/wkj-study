# Final slimming and regression report

Audit date: 2026-07-29 to 2026-07-31  
Validated baselines:

- Ubuntu 24.04.3, GCC/G++ 13.3, Python 3.12.3, project-local Python
  2.7.18, OpenJDK 21 targeting Java 11, and system Z3;
- Ubuntu 20.04 under WSL, GCC/G++ 9.4, Python 2.7.18, Python 3.8 with
  `z3-solver 4.12.2`, Java 11, and system Z3.

## Input and safety boundary

- Original ZIP: 322,149,407 bytes, SHA-256
  `BA12E4431474903D051F69E5F3F6B85FEFB7E5196765015CCB58CAD938F12854`.
- Original ZIP contents: 18,015 files, approximately 1,024.24 MiB
  uncompressed.
- Original ZIP and the full audit extraction were not modified.
- All removals from the submission copy were moved to an external,
  stage-specific quarantine before verification.
- The separate `build.txt` was excluded because it contained a private
  SICStus license value.

## Space reduction

| Stage | Main action | Measured reduction |
|---|---|---:|
| 1 | Git metadata, editor settings, caches, existing objects, logs, backups | about 114.4 MiB |
| 2 | iCPCES local Fast Downward build tree | 509.19 MiB |
| 3 | Public and route-native benchmark whitelist | 256.76 MiB |
| 4a | Runtime results, debug-search duplicates, redundant binaries/examples | 38.75 MiB |
| 4b | Reversible ELF debug-symbol removal | 66.203 MiB |
| 5 | Final regenerated objects, caches, Kissat build, and test results | 15.962 MiB |
| 6 | One unreferenced CpAH timestamped backup found by archive hygiene review | 255 bytes |
| 7 | Nine unreferenced T0 historical result/statistics files | 2,478 bytes |

The Ubuntu 24 reissue contains 1,681 file entries and 58,942,683 bytes
(56.212 MiB) of uncompressed file content. The formal package is about
32.46 MiB, below the 50 MB limit.

## Final retained structure

```text
CE-planner/
├── README.md
├── setup.sh, build.sh, check-installation.sh
├── run-example.sh, run-all-examples.sh
├── plan-cegis, plan-cegis-<12 route wrappers>, plan
├── lama/                         common translator/preprocess/CE search
├── t0-planner/                   T0 runtime
├── T1/                           T1 and c2d
├── conformant-ff/                CFF source and rebuilt executable
├── pond/                         POND executable
├── cnf_planner/, dnf_planner/    CPA-family planners
├── pip_planner/, CpAH/
├── iGC/, GC_LAMA/                GC-family runtimes
├── gCPCES/                       Java source/classes/JARs and FF/MpC
├── iCPCES/                       Python source, optional FD source, FF
├── third_party/kissat/           SAT source and MIT license
├── test/                         selected public and native examples
├── docs/                         dependency, classification, and test reports
├── THIRD_PARTY.md
└── LICENCE
```

## Source recovery and compatibility changes

The B8 archive could not rebuild its core because its Makefile referenced 20
missing current-version source/include files. Only those required files were
recovered from B6 after checking 51 common key files byte-for-byte and
matching B8 V16 markers. No old objects or binaries were substituted.

Additional evidence-led fixes:

- iCPCES field-name and counterexample representation fixes exposed by real
  Python tracebacks and interface comparison.
- T0 quoting/staging fixes for project paths containing spaces.
- gCPCES Java 11 build and isolated FF/MpC/PDDL staging.
- CFF and iGC rebuilt from source recovered from their supplied Git history.
- iGC's old Z3 parser API adapted from a single expression to an expression
  vector without changing constraints.
- CFF compile flags no longer emit debug information.
- Ubuntu 24's PEP 668 system-Python protection is respected by installing
  pinned Python requirements in `.local/python3`.
- Python 3.12 compatibility is retained by pinning setuptools for Z3's
  `pkg_resources` import.
- Every main route entry automatically resolves both project-local Python
  interpreters, including direct invocation outside the convenience test
  scripts.

## Regression matrix after clean build

The reviewer command now uses a different small retained case for each route
where practical instead of applying `blocks/b2` to the entire matrix:

| Route | Case | Result |
|---|---|---|
| T0 | `bomb/p5-1` | `VALID` |
| T1 | `omlette/p3` | `VALID` |
| CFF | `blocks/b2` | `VALID` |
| POND | `safe/p5` | `VALID` |
| CNF | `or-coins/p10` | `VALID` |
| DNF | `blocks/b3` | `VALID` |
| PIP | `or-coins/p15` | `VALID` |
| CpAH | `bomb/p10-1` | `VALID` |
| iGC | `safe/p10` | `VALID` |
| GC-LAMA | `blocks/b3` | `VALID` |
| gCPCES | `safe/p5` | `VALID` |
| iCPCES | `blocks/b3` | `VALID` |

Ubuntu 24.04.3 results after `bash ./build`:

- clean build: passed;
- installation check: `failures=0 warnings=0`;
- `./run-tests --require-all`: `passes=12 failures=0 skips=0`;
- with SICStus hidden: `passes=8 failures=0 skips=4`.

The T1 `blocks/b3` test separately observed refined PDDL generation, a new
counterexample, another refinement round, process-tree timeout cleanup,
native fallback, and final CNF/Kissat `VALID` verification of a 37-step
plan. See `docs/UBUNTU24-VALIDATION.md`.

## Known limitations and submission gates

1. CNF/DNF/PIP/CpAH require a lawful local SICStus license. The external
   SICStus 4.10.1 package was tested successfully, but neither the commercial
   installer nor license data may be redistributed in the submission ZIP.
2. `IGC_CEGIS_SELFTEST=1` returns `BACKEND_ERROR` in both the supplied
   binary baseline and the rebuilt core. Real route regressions pass; this
   remains a pre-existing self-test defect.
3. The supplied archive lacks the CE-planner paper title/authors/BibTeX and
   a public full-benchmark URL. Authors must add authoritative metadata.
4. Complete license texts or redistribution permission are missing for
   several historical candidate-planner binaries and gCPCES JARs. See
   `THIRD_PARTY.md`; public release should wait for license clearance.
5. The included `blocks/b3` is a useful multi-round example, but the input
   did not identify the paper's authoritative “native-hard, CE-easy”
   benchmark. Authors must nominate and document that instance rather than
   infer it from these smoke tests.
6. Existing compiler warnings include non-void functions without a return,
   old C sequence-point expressions, and fixed-size string operations.
   They were not silently changed during a packaging task.

## Acceptance conclusion

The package meets the measured size limit, preserves all 12 route entry
points and their audited dependencies, rebuilds all components for which
corresponding source was present, and passes all 12 routes after clean
compilation when a licensed SICStus 4.10.1 installation is available. It
also degrades cleanly to 8 passing open routes plus 4 explicit skips when
SICStus is absent. Missing bibliographic/benchmark metadata and incomplete
third-party license provenance remain author-side publication gates.
