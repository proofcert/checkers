## Checkers

Checkers is a λ-prolog implementation of a tool for checking 
proofs output by theorem provers. It is based on the theory of
foundational proof certificates (see, for example, [here](http://www.lix.polytechnique.fr/~dale/papers/cade2013.pdf)).

Currently it has support for checking some of the proofs from
[e-prover](http://eprover.org). This means we are able to parse the proofs
into λ-prolog modules which can than be checked by checkers.

The parser, implemented in OCaml, can be found in `proofs/tstpparser`.
Just type `make` inside this directory and you will obtain an executable
`tstpparser` which can be run on e-prover's proof evidence resulting on
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

Checkers can be (compiled and) run using the `prover.sh` script.
The sole argument of this script must be the λ-prolog module
containing the proof certificate the user wants to check.
Additionally, this module and corresponding signature must be 
in the `src` directory **or** in one of the subdirectories of 
`tests`.

If you don't want to generate your own certificate, there are
some inside `tests/eprover` ready to go. All you need to do is,
from the top-level directory, execute:

```
./prover.sh module_name
```
