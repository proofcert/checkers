sig simpfit-tableaux.

accum_sig lists.
accum_sig certificatesLKF.
accum_sig fittings-tableaux.

kind closure, boxinfo, use type.

type closure index -> index -> closure.
type boxinfo index -> index -> boxinfo.
type use index -> use.

% simpfitcert has 6 arguments
% 1 and 2 are used for the indexing mechanism
% 1) int : it is either 0 (do not create subindexes when you apply a rule) or 1 (create subindexes when you apply a rule)
% 2) list index : the index(es) of the formula(s) currently being considered
% 3) list closure : list of pairs (index of positive formula, index of negative formula) used in the init rule
% 4) list boxinfo : list of pairs (index of box formula, index of corresponding diamond formula)
% 5) list (pair index atm) : list of pairs (index of diamond, corresponding eigenvariable)
% 6) list use : list of indexes of formulas on which decide is allowed

type simpfitcert int -> list index -> list closure -> list boxinfo -> list (pair index atm) -> list use -> cert.
