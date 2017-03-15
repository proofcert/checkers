## Checkers

Checkers is a λ-prolog implementation of a tool for checking
proofs output by theorem provers. It is based on the theory of
foundational proof certificates (see, for example, [here](http://www.lix.polytechnique.fr/~dale/papers/cade2013.pdf)).

Currently it has support for checking some of the proofs from
[e-prover](http://eprover.org). This means we are able to parse the proofs
into λ-prolog modules which can than be checked by checkers.

### Installation

The proof checking component of checkers is implemented in λ-prolog.
The E-prover parser is implemented in OCaml.
* Checkers depends on the Teyjus implementation of λ-prolog.
Teyjus can be found here [here](https://github.com/teyjus/teyjus).
Please install version 2.1 or later.
* The parser can be found in `proofs/tstpparser`.
Just type `make` inside this directory and you will obtain an executable
`tstpparser`

### Usage

#### Parser

The executable `tstpparser` can be run on e-prover's proof evidence resulting on
a `.mod` and a `.sig` λ-prolog files (proof certificates). For instance,
the following set of commands:

```
cd proofs/tstpparser
make
cd ..
./tstpparser/tstpparser simple.out simple
```

will generate the `simple.mod` and `simple.sig` files in the
`proofs` directory which correspond to the certificate of the
proof in `simple.out`.

#### Checkers

The script `prover.sh` can be used to compile and run \checkers\ on given certificates.
The argument for Checkers is the name of the `.mod` and `.sig` files of the certificate, which must be placed in the `src` folder.
For example, in order to check the proof certificate contained in the
files `simple.mod` and `simple.sig`, one needs to place them in the `src` folder and execute the following command:

```
./prover.sh simple
```

Checkers was tested under Debian 8 and Fedora 21. The shell scripts are
written for bash.

### Structure

The program contains the following files and directories.
  * `proofs` directory which contains utilities and examples for interfacing with E-prover.
  * `src` directory contains the λ-prolog code of the program, including the `FPC` for E-prover.
  * `README` file which contains instructions of how to run the program.
  * `prover.sh` script for running Checkers on a given certificate name.
  * `prover-debug.sh` script for running Checkers in debugging mode. This should mainly be used by
    implementors of FPCs.

### Examples

Some certificates for testing can be found in the folder `src/tests/resolution`.
These certificates are already included in the path and can be checked without the need to copy them first to the `src` folder.

### Certificate formats

Checkers currently supports certification of two forms of resolution proofs. Please refer to the [system description of Checkers](http://logic.at/staff/shaolin/papers/checkers.pdf)
for more information about the two formats.
Examples of the two forms can be seen in the problems `eprover1` and `eprover2` which can be found in the `tests` directory.

# Comments

* Checkers requires the latest version of Teyjus in order to properly
  handle paths. It should be noted that the program prover-debug.sh
does not require the latest version of Teyjus and can be tried without
the intallation of the later.

```
./prover-debug.sh module_name

```
