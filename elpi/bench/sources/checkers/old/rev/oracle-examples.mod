module oracle-examples.
accumulate control.
accumulate lkf-formulas, cforms, lkf-polarize.
% accumulate lkf-kernel.
accumulate lkf-hosted.
accumulate oracle-fpc.
accumulate spy.

polarize_pos A.  % All atoms are polarized negatively.

test_all :- example X Form Oracle,
            (sigma Str\ term_to_string X Str, print Str, print " "),
            if (polarize+ Form B, lkf_entry (start Oracle) B)
               (print "Success\n") (print "Fail\n"),
            fail.

test N :- example N Form Oracle, polarize+ Form B, lkf_entry (start Oracle) B.

example 1 (a or (neg a)) (r (l emp)).

example 2 ((neg b) or ((b and (neg a)) or ((a and (neg d)) or d)))
          (l 
          (r (l (c emp 
          (r (r (l (c emp 
          (r (r (r emp))))))))))).

example 3 (((a imp b) imp a) imp a) (l (c (l (r emp)) (r emp))).

% The following example should fail.
example 4 (((a imp b) imp a) imp a) (l (c (r (r emp)) (r emp))).


