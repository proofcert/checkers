module cforms.

non_atomic tt         & non_atomic ff.
non_atomic (neg _).
non_atomic (_ and _)  & non_atomic (_ or _).
non_atomic (_ imp _)  & non_atomic (_ equiv _).
non_atomic (forall _) & non_atomic (exists _).

atomic A :- non_atomic A, !, fail.  % NAF here.
atomic A.

