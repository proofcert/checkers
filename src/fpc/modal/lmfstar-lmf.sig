sig lmfstar-lmf.

accum_sig certificatesLKF.
accum_sig certificatesLMF.
accum_sig lists.
accum_sig base.

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.

% fixed index for relations, should be improved!
type relind index.

% The certificate for the translation is polymorphic but keep trace of which branch we are in: modal one
% or the one generated by the translation from fol
kind phase type.
type prf, tns phase.

% arguments: lmfstar cert, set H, future, list of indexes for multifocusing
type mstarcert cert -> list label -> label -> list index -> cert.

