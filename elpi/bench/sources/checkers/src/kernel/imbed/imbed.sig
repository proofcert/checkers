sig imbed.
accum_sig lkf-kernel, ljf-kernel, base.

%maybe even form and seq should be turned into formK and formJ and seqK and seqJ?
type entry_pointImbed  		cert -> form -> o.
type imbedForm-, imbedForm+ 	form -> form -> o.
type imbedSeq 			seq -> seq -> o.
type imbed-AllForm 		list form -> list form -> o.

type fcert cert.

% TODO: remove the tests from the file eventually
type test int -> A -> B -> o.


