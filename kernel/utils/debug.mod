% 29 july 2014.
module debug.
accumulate lists.
% Debugging tools
type bracket          		string -> o -> string -> o.

bracket Pre G Post :- print Pre, term_to_string G S, print S, print Post.
announce G :- bracket ">>" G "\n", fail.
%spy G :- (bracket ">Entering " G "\n", G, bracket ">Success  " G "\n";
%          bracket ">Leaving  " G "\n", fail).
spy G :- G.
print_r G :- print G.
%print_r G.

if P Q R :- P, !, Q.
if P Q R :- R.

spyV 1 Stra G :-

	(print ">>> ", print Stra, print " ", term_to_string G Str,  print Str,  print "\n", G,
	 print "+++ ", print Stra, print " ", term_to_string G Strx, print Strx, print "\n")
	;
	(print "<<< ", print Stra, print " ", term_to_string G Str,  print Str,  print "\n", fail).

spyV 0 Stra G :- G.
