# Ubuntu 24.04 validation report

Validation date: 2026-07-31

## Environment

- Ubuntu 24.04.3 LTS, x86-64
- GCC/G++ 13.3.0 and glibc 2.39
- Python 3.12.3 plus project-local Python 2.7.18
- OpenJDK 21, with gCPCES compiled for Java 11
- project-local `z3-solver==4.12.2.0`
- optional project-local SICStus Prolog 4.10.1

## Reviewer workflow

The final workflow is:

```bash
bash ./build
./run-tests
```

`build` restored permissions, installed the open dependencies, completed a
clean C/C++/Java build, and ran the installation check. The observed result
was:

```text
Build completed successfully.
failures=0 warnings=0
CE-planner is ready. Run: ./run-tests
```

Ubuntu 24 has no supported Python 2 package, so setup built Python 2.7.18
under `.local/python2`. Python 3 dependencies were installed under
`.local/python3`; the system-managed Python environment was not modified.

## SICStus boundary

The separately supplied
`sp-4.10.1-x86_64-linux-glibc2.28.tar.gz` was checksum-verified, installed
under a temporary project-local prefix, and reported SICStus 4.10.1.

The final source ZIP does not contain this commercial archive or any license
data. `install-sicstus.sh` locates the external archive, verifies its exact
checksum, and invokes the vendor installer interactively. A failed or
declined optional installation does not block the 8 open routes.

## Route regression

With licensed SICStus available, `./run-tests --require-all` produced:

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

Summary:

```text
passes=12 failures=0 skips=0
```

The same matrix was run with SICStus hidden. The 8 open routes remained
`VALID` and the four licensed routes were reported as explicit skips:

```text
passes=8 failures=0 skips=4
```

## Executable-permission validation

To simulate extracting on Windows and then copying to Linux, every packaged
file's executable bit was removed in a disposable validation tree. Running
the permission restorer recovered 192 packaged shebang/ELF entries based on file content, not
filename, and the subsequent clean build and 12-route regression passed.

A normal Ubuntu `unzip` also preserves the POSIX modes stored in the archive.
Therefore reviewers do not need to run a manual recursive `chmod +x`.
