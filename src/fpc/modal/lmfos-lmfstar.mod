module os-lmfstar.

% Translation between the fake calculus OS to LMF*. Is the base for other prfal translations.

% osphase is used when we apply a modal rule: one phase for the box, one for the diamonds
% list index is the possible list of diamonds we need to keep track of
% the two atoms are current and next labels
% type oscert : cert osphase -) list index -) atm -) atm

% Decide corresponding to the application of a modal rule (we enter a boxphase)
decide_mstare (oscert C normalphase [] PresentLabel _) [BoxIndex] [PresentLabel] Future (oscert C' boxphase DiaIndexList PresentLabel _) :- 
modal_ose C BoxIndex DiaIndexList C'.

% Decide corresponding to the application of a modal rule (2nd part: we exit the boxphase)
decide_mstare (oscert C boxphase DiaIndexList PresentLabel FutureLabel) DiaIndexList [FutureLabel] FutureLabel (oscert C' normalphase [] FutureLabel _).

% Decide corresponding to the application of a classical connective rule
decide_mstare (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- and_ose C Index C'.
decide_mstare (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- or_ose C Index C'.
decide_mstare (oscert C normalphase [] PL FL) [Index] [PL] _ (oscert C' normalphase [] PL FL) :- init_ose C Index C'.

% uses the label introduced here as the next future label
box_mstarc (oscert C normalphase DIL PL _) Lbl (oscert C normalphase DIL PL Lbl).

store_mstarc (oscert C PH DIL PL FL) _ _ (oscert C PH DIL PL FL).

release_mstare (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

% shall we add some info here?
initial_mstare (oscert C PH DIL PL FL) _.

orNeg_mstarc (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

andNeg_mstarc (oscert C PH DIL PL FL) (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).

dia_mstare (oscert C PH DIL PL FL) (oscert C PH DIL PL FL).