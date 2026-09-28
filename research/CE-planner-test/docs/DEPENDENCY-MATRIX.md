# CE-planner dependency and route matrix

This document records the static call graph and the representative dynamic
test used to protect every candidate-planner route. Paths are relative to the
package root.

## Shared CE-planner chain

```text
plan-cegis-<route>
  -> plan-cegis
  -> plan
  -> lama/translate/translate.py
  -> lama/preprocess/preprocess
  -> lama/search/release-search
       -> refined artifact writer
       -> route adapter and candidate planner
       -> candidate-plan parser
       -> CNF/Z3/Kissat verifier
       -> counterexample store or final acceptance
```

Shared build dependencies are GCC/G++, GNU Make, Z3 headers/library, and
`third_party/kissat`. Shared runtime dependencies are Bash, Python 2.7, the
core LAMA binaries, `test/.native-fallback`, and normal POSIX process/file
operations.

## Per-route dependencies

| Route | CE entry and candidate call | Required package paths | External dependency | Representative test and expected result |
|---|---|---|---|---|
| T0 | `plan-cegis-t0`; T0 translator invokes its fixed-name helper programs | `t0-planner/translator/translator/{translator-t0,translator,cf2cs,prime-impl,validate,cconf,plannf,ff,2sat,relsat,c2d_220,...}`; native `T0-Benchmark-success` | Python 2 and 32-bit GNU/Linux runtime | `blocks/b2`, candidate starts, translated PDDL is consumed, final `VALID` |
| T1 | `plan-cegis-t1`; `T1/t1` loads the d-DNNF compiler | `T1/t1`, `T1/libdnnf/c2d_linux`; native `T1-Benchmark-succes` | 32-bit GNU/Linux runtime | `blocks/b2` fast `VALID`; `blocks/b3` exercises counterexample refinement and fallback |
| CFF | `plan-cegis-cff`; `conformant-ff/ff -o <domain> -f <problem>` | CFF C sources, `conformant-ff/makefile`, rebuilt `ff`; native `CFF-Benchmark-succes` | GCC and libc/libm | `blocks/b2`, stdout plan parsed, final `VALID` |
| POND | `plan-cegis-pond`; `pond/pond -s astar -h card -p fog ...` | `pond/pond`; native `POND-Benchmark-succes` | Bundled 64-bit ELF | `blocks/b2`, plan parsed, final `VALID` |
| CNF | `plan-cegis-cnf`; CPA PDDL converter → Prolog preprocessing → `cnf` | `cnf_planner/{cpa.pddl2pl,mult5zsic.pl,sic_script.sh,cnf}` plus AL/Prolog templates; native `CNF-Benchmark-succes` | Perl, licensed SICStus Prolog 4.x, 32-bit runtime for converter | `blocks/b2`; audit reached the SICStus call and stopped with `sicstus: not found` |
| DNF | `plan-cegis-dnf`; CPA front end → `dnf`; may use CNF recovery | `dnf_planner/*`, shared `cnf_planner/*`; native `DNF-Benchmark-succes` | Perl, licensed SICStus Prolog 4.x | `blocks/b2`; audit reached the SICStus call and stopped on the missing external dependency |
| PIP | `plan-cegis-pip`; CPA front end → `pip`; may use CNF recovery | `pip_planner/*`, shared `cnf_planner/*`; native `PIP-Benchmark-succes` | Perl, licensed SICStus Prolog 4.x | `blocks/b2`; audit reached the SICStus call and stopped on the missing external dependency |
| CpAH | `plan-cegis-cpah`; CPA front end → AL theory bundle → `CPAH` | `CpAH/{cpa.pddl2pl,cpa2.pddl2pl,mult5zsic.pl,CPAH,CPAC}` and AL templates; native `CPA-Benchmark-succes` | Perl, licensed SICStus Prolog 4.x, 32-bit converter runtime | `blocks/b2`; audit reached the SICStus call and stopped on the missing external dependency |
| iGC | `plan-cegis-igc`; Python translator → preprocessor → rebuilt search | `iGC/lama/{translate,preprocess,search}`; native `iGC-Benchmark-succes` | Python 2, Z3 | `blocks/b2`, isolated workspace, final `VALID` |
| GC-LAMA | `plan-cegis-gc-lama`; Python translator → preprocessor → search | `GC_LAMA/lama/{translate,preprocess,search}`; native `GC-Benchmark-succes` | Python 2 | `blocks/b2`, isolated workspace, final `VALID` |
| gCPCES | `plan-cegis-gcpces`; Java `main` stages FF/MpC into its workspace | `gCPCES/{src,build,libs,ff,MpC}`, `compile-java.sh`; native `gCPCES-Benchmark-succes` | Java 11-compatible runtime and bundled JNI Z3 | `blocks/b2`, Java process and FF backend run, final `VALID` |
| iCPCES | `plan-cegis-icpces`; Python sampling/refinement → FF by default | `iCPCES/*.py`, `ConformantPlanning`, `translate`, `classical_planner/ff`; retained Fast Downward source is optional; native `ICPCES-Benchmark-succes` | project Python 3 venv with `setuptools==69.5.1` and `z3-solver==4.12.2.0` | `blocks/b2`, PDDL and candidate plan produced, final `VALID` |

## Dependency classes

- **Compile time:** GCC/G++, Make, CMake, Flex/Bison, Z3 development files,
  Kissat source, Java compiler.
- **Common runtime:** Bash, Python 2.7, core translator/preprocessor/search,
  native-fallback files, C/C++ runtimes.
- **Route runtime:** the executables, scripts, JARs, and JNI library listed
  above.
- **Commercial runtime:** SICStus, used only by CNF/DNF/PIP/CpAH.
- **Development/test only:** complete benchmark corpora, Git history,
  compiler objects, caches, historical results, Kissat's own test corpus,
  and local Fast Downward build trees.

## Dynamic validation boundary

The eight open-dependency routes completed candidate generation, plan
parsing, and final common verification after the last binary-size reduction.
The four CPA-family routes were not called end-to-end because no lawful
SICStus installation was available. Their converters and scripts reached the
external `sicstus` invocation; they remain packaged and must be retested in
the authors' licensed environment.
