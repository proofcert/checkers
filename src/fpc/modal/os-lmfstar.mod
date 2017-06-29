module os-lmfstar.

% Translation between the fake calculus OS to LMF*. Is the base for other prfal translations.

% Decide corresponding to the application of a modal rule (we enter a boxphase)
decide_mstar_ke (oscert C normalphase [] PresentLabel _) [BoxIndex] [PresentLabel] Future (oscert C' boxphase DiaIndexList PresentLabel _) :-
  modal_os_ke C BoxIndex DiaIndexList C'.

% Decide corresponding to the application of a modal rule (2nd part: we exit the boxphase)
decide_mstar_ke (oscert C boxphase DiaIndexList PresentLabel FutureLabel) DiaIndexList [FutureLabel] FutureLabel (oscert C' normalphase [] FutureLabel _).

% Decide corresponding to the application of a classical connective rule
decide_mstar_ke (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- and_os_ke C Index C'.
decide_mstar_ke (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- or_os_ke C Index C'.
decide_mstar_ke (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- init_os_ke C Index C'.

% uses the label introduced here as the next future label
box_mstar_kc (oscert C normalphase DIL PL _) Lbl (oscert C normalphase DIL PL Lbl).

store_mstar_kc (oscert C PH DIL PL FL) _ _ (oscert C PH DIL PL FL).

release_mstar_ke (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

% shall we add some info here?
initial_mstar_ke (oscert C PH DIL PL FL) _.

orNeg_mstar_kc (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

andNeg_mstar_kc (oscert C PH DIL PL FL) (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

dia_mstar_ke (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).
