module debug.
accumulate lists.

type announce, spy    o -> o.
type bracket          string -> o -> string -> o.  % Auxiliary

bracket Pre G Post :- print Pre, term_to_string G S, print S, print Post.
announce G :- bracket ">>" G "\n", fail.
spy G :- (bracket ">>> " G "\n", G, bracket "+++  " G "\n";
          bracket "<<<  " G "\n", fail).


if P Q R :- P, !, Q.
if P Q R :- R.
