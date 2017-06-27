module lmfs.

accumulate lmf-lkf.

decidem_ke (lmfs-cert (dectree I D) M1 M2 Bnd (state _ M3 M4)) I (lmfs-cert (dectree I D) M1 M2 Bnd (state [] M3 M4')) :-
    reduce_or_set_decide_bound M4 I (snum _) M4'.

% this fails if it doesnt find an entry with value greater than znumnum
reduce_or_set_decide_bound [decide-bound-entry I (snum B)| R] I (snum B) [decide-bound-entry I B| R]. % reduce if found
reduce_or_set_decide_bound [X|L] I B [X|L'] :- reduce_or_set_decide_bound L I B L'.

storem_kc (lmfs-cert DT M1 M2 Bnd (state [H|T] M3 M4)) _ H (lmfs-cert DT M1 M2 Bnd (state T M3 [decide-bound-entry H Bnd | M4])).

releasem_ke C C.

initialm_ke (lmfs-cert (dectree I _) _ (init-map M2) _ _) O :- member (init-entry I O) M2.

orNegm_kc (lmfs-cert (dectree I [D]) M1 M2 Bnd (state [] M3 M4)) _ (lmfs-cert D M1 M2 Bnd (state [lind I, rind I] M3 M4)).

andNegm_kc (lmfs-cert (dectree I [D1,D2]) M1 M2 Bnd (state [] M3 M4)) _
  (lmfs-cert D1 M1 M2 Bnd (state [lind I] M3 M4)) (lmfs-cert D2 M1 M2 Bnd (state [rind I] M3 M4)).

andPosm_k (lmfs-cert (dectree I D) M1 M2 Bnd S) _ left-first
  _ (lmfs-cert (dectree I D) M1 M2 Bnd S).

boxm_kc (lmfs-cert (dectree I [S]) M1 M2 Bnd (state [] M3 M4))
  (Eigen\ lmfs-cert S M1 M2 Bnd (state [lind I] [eigen-entry I Eigen|M3] M4)) :-
  member (eigen-entry I _) M3, !, fail.
boxm_kc (lmfs-cert (dectree I [S]) M1 M2 Bnd (state [] M3 M4))
  (Eigen\ lmfs-cert S M1 M2 Bnd (state [lind I] [eigen-entry I Eigen|M3] M4)).

diam_ke (lmfs-cert (dectree I [S]) (diabox-map M1) M2 Bnd (state [] M3 M4)) Eigen
  (lmfs-cert S (diabox-map M1) M2 Bnd (state [bind I O] M3 M4)) :-
  (member (diabox-entry I O) M1, member (eigen-entry O Eigen)  M3).
