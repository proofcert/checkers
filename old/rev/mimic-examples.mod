module mimic-examples.
accumulate control.
accumulate ljf-formulas, iforms, ljf-polarize.
accumulate ljf-kernel.
accumulate lists.
accumulate mimic-fpc.

trans tt t-.
trans ff f.
trans (T imp S) (A arr B) &
trans (T and S) (A &-& B) &
trans (T or  S) (A !+!  B) :- trans T A, trans S B.
trans a (p a)  &  trans b (p b)  &  trans c (p c) &  trans d (p d).

check_cert IForm :- 
  trans IForm Form, (d+ Form) = Form', 
  ljf_entry (mimic root) (Form' arr Form').

test I :- example I IForm, check_cert IForm.

test_all :- 
   example X IForm,
   (sigma Str\ term_to_string X Str, print Str, print " "),
   if (check_cert IForm)
      (print "Success\n") 
      (print "Fail\n"), 
  fail.

example 1 (a and b).
example 2 (a and b and c).
example 3 (a or b or c).
example 4 (a or (b imp c)).
example 5 (a imp b).
example 6 (a imp b imp c).
example 7 ((a imp b) imp c).
example 8 (((a and (b or c)) imp (b or c)) imp c).
example 9 tt.
example 10 ff.
example 11 a.
