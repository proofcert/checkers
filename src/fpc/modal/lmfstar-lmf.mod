module lmfstar-lmf.

% Translation between the fake calculus LMF* to LMF. Is the base for other prfal translations.

% Decide when the multifocusing sets are empty: it corresponds to a decide in LMF*
decide_m_ke (mstarcert C Present _ []) Index Label (mstarcert C' Present' Future Multifocusing) :-
  decide_mstar_ke C [Index|Multifocusing] Present' Future C', member Label Present.

% Decide emulating multifocusing
decide_m_ke (mstarcert C Present Future [Index|Multifocusing]) Index Label (mstarcert C Present Future Multifocusing) :-
  member Label Present.

store_m_kc (mstarcert C Present Future Multifocusing) I (mstarcert C' Present Future Multifocusing) :- store_mstar_kc C I C'.

release_m_ke (mstarcert C Present Future Multifocusing) (mstarcert C' Present Future Multifocusing) :- release_mstar_ke C C'.

initial_m_ke (mstarcert C _ _ _) I :- initial_mstar_ke C I.

orNeg_m_kc (mstarcert C Prs Fut Mlt) (mstarcert C' Prs Fut Mlt) :- orNeg_mstar_kc C C'.

andNeg_m_kc (mstarcert C Prs Fut Mlt) (mstarcert C' Prs Fut Mlt) (mstarcert C'' Prs Fut Mlt) :- andNeg_mstar_kc C C' C''.

box_m_kc (mstarcert C Prs Fut Mlt) Lbl (Eigen\ mstarcert (C' Eigen) Prs Fut Mlt) :- box_mstar_kc C Lbl C'.

dia_m_ke (mstarcert C Prs Fut Mlt) Fut (mstarcert C' Prs Fut Mlt) :-
  dia_mstar_ke C C'.
