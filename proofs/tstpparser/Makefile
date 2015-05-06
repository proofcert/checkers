all:
	ocamllex tstplexer.mll
	ocamlyacc tstpparser.mly
	ocamlc -c proof.ml
	ocamlc -c tstpparser.mli
	ocamlc -c tstplexer.ml
	ocamlc -c tstpparser.ml
	ocamlc -c main.ml
	ocamlc str.cma -o tstpparser proof.cmo tstplexer.cmo tstpparser.cmo main.cmo

clean:
	rm -f *.cmo *.cmi tstpparser.mli tstplexer.ml tstpparser.ml tstpparser

