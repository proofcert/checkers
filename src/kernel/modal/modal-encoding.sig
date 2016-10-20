sig modal-encoding.

accum_sig lkf-syntax.
accum_sig modal-syntax.

% this kind denotes a world
% a world is just an index or the intial world
kind world type.
type iworld world.
type nworld index -> world.

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.

type modalToLK modform -> (A -> form) -> o.
% type modalToLK A -> modform -> form -> o.
type optdel (A -> form) -> (A -> form) -> o.
% type optdel form -> form -> o.
type zero, x, y, z A.
