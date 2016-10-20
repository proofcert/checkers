sig modal-encoding.

accum_sig lkf-syntax.
accum_sig modal-syntax.

% this kind denotes a world
% a world is just an index or the intial world
% we use A for world and not the type world because world denotes both indices and eignvariables
% we need to find a better way to map between the two. Right now the map is part of the state of lmf-singlefoc
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
