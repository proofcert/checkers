sig jhc-examples.
accum_sig iforms, ljf-kernel.
accum_sig jhc-fpc.

type test_all     o.
type test         int -> o.
type example      int -> iform -> list index -> list just -> o.

type a, b, c, d   i.
/* predicates */
type adj, path    i -> i -> iform.
/* end */

type ab, ba, inc, tran, pab, pba, paa     index.
type bc, cd, pac, pad, pbc, pcd           index.

/* fregecode */
type  v, w  i.            % Two propositional variables
type  bot   i.            % classical false
type  ar    i -> i -> i.  % classical implication
infix ar    4.
type  pv    i -> iform.   % Provability predicate
/* end */

type box   i -> i.

type aa, bb, cc, mp, gg, tax, s4    index.
