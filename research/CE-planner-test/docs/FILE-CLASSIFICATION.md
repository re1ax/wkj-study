# File classification and handling evidence

The original archive contained 18,015 files and approximately 1,024.24 MiB
uncompressed. The original ZIP and a full read-only extraction were kept
outside this submission tree. Every removal described below was first moved
to an audit quarantine.

## A — must retain

| Paths or set | Purpose | Evidence |
|---|---|---|
| `plan-cegis*`, `plan`, `run-test-ce.sh` | CE entry, route selection, process control | Direct invocation by every tested route |
| `lama/translate`, `lama/preprocess`, `lama/search` sources and final binaries | PDDL→SAS, preprocessing, CE loop, SAT verification | Build graph and `strace` on the T1 multi-round test |
| `third_party/kissat` source and license | Linked common SAT backend | Core Makefile and final verifier logs |
| All 12 route directories and wrappers | Candidate generation and planner-specific parsing | Static process call graph and route matrix |
| Selected `test/` and corresponding `.native-fallback` domains | Fast examples and original-planner fallback | Native preflight and actual fallback file reads |
| Project/component licenses, README, scripts, audit documents | Reproducibility and redistribution review | Submission requirements |

## B — verified removable or regenerable

| Removed set | Original scale | Evidence |
|---|---:|---|
| Root, iGC, and Kissat `.git` metadata | about 105.91 MiB | No build/runtime read; history is not source input |
| Editor metadata and machine reports | less than 0.1 MiB | Development-only; included private absolute paths |
| Compiler objects, Python caches, coverage/profiling files | hundreds of MiB including Fast Downward objects | Rebuilt from retained sources; runtime loads final binaries |
| `runs/`, logs, result directories, root SAS/plan artifacts | varies per execution | Created afresh by regression tests |
| `iCPCES/downward/builds` | 509.19 MiB, 553 files | FF-backed iCPCES passed before and after isolation; Fast Downward source retained |
| Redundant gCPCES `src/ff`, `src/MpC`, stale `.class` files | 2.15 MiB | Java source now stages root binaries; gCPCES passed after isolation |
| GC/iGC debug `search` and duplicate external `verify` copies | 18.25 MiB | Static workspace code stages only `release-search`; both routes passed after isolation |
| Kissat's internal test corpus | 1.10 MiB | Not referenced by core build or verifier runtime |
| Historical backup files and generated CPA residues | small | Formal same-source file retained; no current script referenced backup name |

## C — replaced or reduced

| Set | Action | Verification |
|---|---|---|
| Public and native benchmark corpora | Whitelisted six public domains and route-specific native domains | T1 multi-round and route matrix rerun |
| iCPCES's own benchmark examples | Kept only a tiny blockworld example; removed development corpora | iCPCES uses explicit CE inputs and passed after reduction |
| POND, T0, T1, CFF, GC/iGC, CPA-family and shared ELF files | Backed up, then removed unneeded debug symbols | 36 files: 86.715→20.512 MiB; all eight open routes passed |
| CFF | Restored complete C sources from the supplied repository history and rebuilt on Ubuntu 20.04 | `blocks/b2` final `VALID` |
| iGC search | Restored its own source revision, adapted old Z3 vector API, rebuilt | `blocks/b2` final `VALID` |
| gCPCES Java classes | Recompiled with `javac --release 11`; fixed isolated staging of FF/MpC and PDDL inputs | `blocks/b2` final `VALID` |

## D — retained pending confirmation

| Item | Risk or unknown | Required follow-up |
|---|---|---|
| CPA-family generated AL/Prolog templates | SICStus may load fixed-name files dynamically | Trace CNF/DNF/PIP/CpAH in a licensed SICStus environment before any further reduction |
| gCPCES JAR set, especially `fastutil` | Reflection/transitive class loading makes per-JAR deletion risky | Keep for submission unless a Java class-load trace proves a smaller set |
| Historical external planner binaries | Complete source/license was not present for several planners | Obtain authoritative source and redistribution permission |
| Core `IGC_CEGIS_SELFTEST=1` | Returns `BACKEND_ERROR` in both supplied and rebuilt baseline | Treat as a known pre-existing self-test defect; real route tests remain authoritative |
| Full benchmark URL and CE-planner BibTeX | Not present in supplied files | Authors must add artifact DOI/URL and paper citation before submission |
| Native-hard/CE-easy benchmark claim | The included b3 demonstrates refinement and fallback, not a proven comparative performance result | Authors must nominate and document the paper's authoritative instance |

## Safety and rollback

The audit tree records the original input hashes, the source recovery
evidence, and quarantine contents for every stage. Nothing in the quarantine
is included in the final submission archive. No removal was performed on the
only copy of the original ZIP.
