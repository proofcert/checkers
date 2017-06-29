module lmfstar-lmf.

% Translation between the fake calculus LMF* to LMF. Is the base for other prfal translations.

% Decide when the multifocusing sets are empty: it corresponds to a decide in LMF*
decide_me (mstarcert C Present _ [] []) Index Label (mstarcert C' Present' Future Multifocusing) :- decide_mstare C 
[Index::Multifocusing] Present' Future C', member Label Present.

% Decide emulating multifocusing
decide_me (mstarcert C Present Future [Index::Multifocusing] Index Label (mstarcert C Present Future Multifocusing) :- member Label Present.

store_mc (mstarcert C Present Future Multifocusing) F I (mstarcert C' Present Future Multifocusing) :- store_mstarc C F I C'.

release_me (mstarcert C Present Future Multifocusing) (mstarcert C' Present Future Multifocusing) :- release_mstare C C'.

initial_me (mstarcert C _ _ _) I :- initial_mstare C I.

orNeg_mc (mstarcert C Prs Fut Mlt) (mstarcert C' Prs Fut Mlt) :- orNeg_mstarc C C'.

andNeg_mc (mstarcert C Prs Fut Mlt) (mstarcert C' Prs Fut Mlt) (mstarcert C'' Prs Fut Mlt) :- andNeg_mstarc C C' C''.

box_mc (mstarcert C Prs Fut Mlt) Lbl (mstarcert C' Prs Fut Mlt) :- box_mstarc C Lbl C'.

dia_me (mstarcert C Prs Fut Mlt) Fut (mstarcert C' Prs Fut Mlt) :-
  dia_mstare C C'.