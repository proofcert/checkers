sig ljf-syntax.

kind rhs                                 type.   % The RHS of the async sequent
type str, unk                     form -> rhs.   % The right-hand-side is either unknown or stored.

kind seq                                 type.   % Sequents
type async           list form -> rhs  -> seq.   % async
type lfoc                 form -> form -> seq.   % left focus
type rfoc                         form -> seq.   % right focus

type storage               index -> form -> o.  % The table for stored formulas.
