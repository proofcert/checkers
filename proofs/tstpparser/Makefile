all:
	ocamllex tstplexer.mll
	ocamlyacc tstpparser.mly
	ocamlc -c tstpparser.mli
	ocamlc -c tstplexer.ml
	ocamlc -c tstpparser.ml
	ocamlc -c main.ml
	ocamlc -o tstpparser tstplexer.cmo tstpparser.cmo main.cmo

clean:
	rm -f *.cmo *.cmi tstpparser.mli tstplexer.ml tstpparser.ml tstpparser

