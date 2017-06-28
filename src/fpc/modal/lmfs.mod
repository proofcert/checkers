module lmfs.

accumulate lmf-lkf.

decidem_ke (lmfs-cert (dectree I D) M1 M2 Bnd (state _ M4)) I MF (lmfs-cert (dectree I D) M1 M2 Bnd (state [] M4')) :-
    reduce_or_set_decide_bound M4 I (snum _) M4'.

% this fails if it doesnt find an entry with value greater than znumnum
reduce_or_set_decide_bound [decide-bound-entry I (snum B)| R] I (snum B) [decide-bound-entry I B| R]. % reduce if found
reduce_or_set_decide_bound [X|L] I B [X|L'] :- reduce_or_set_decide_bound L I B L'.

storem_kc (lmfs-cert DT M1 M2 Bnd (state [H|T] M4)) _ H (lmfs-cert DT M1 M2 Bnd (state T [decide-bound-entry H Bnd | M4])).

releasem_ke C C.

initialm_ke (lmfs-cert (dectree I _) _ (init-map M2) _ _) O :- member (init-entry I O) M2.

orNegm_kc (lmfs-cert (dectree I [D]) M1 M2 Bnd (state [] M4)) _ (lmfs-cert D M1 M2 Bnd (state [lind I, rind I] M4)).

andNegm_kc (lmfs-cert (dectree I [D1,D2]) M1 M2 Bnd (state [] M4)) _
  (lmfs-cert D1 M1 M2 Bnd (state [lind I] M4)) (lmfs-cert D2 M1 M2 Bnd (state [rind I] M4)).

boxm_kc (lmfs-cert (dectree I [S]) (labels-map M1) M2 Bnd (state [] M4)) Label
  (Eigen\ lmfs-cert S (labels-map M1) M2 Bnd (state [lind I]  M4)):-
  member (label-entry I Label) M1.

diam_ke (lmfs-cert (dectree I [S]) (labels-map M1) M2 Bnd (state [] M4)) Label
  (lmfs-cert S (labels-map M1) M2 Bnd (state [bind I O] M4)) :-
  member (label-entry I Label) M1.
