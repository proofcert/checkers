module bfol3.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol3"
 ((some (x\ (some y\ (n(g(x)) &+& n(g(f x y))) &+& n(g(y))))) !-!
  (p (g(a))) !-!
  (p (g(f a b))) !-!
  (p (g(b))))
 (rsteps [resolv (rid (idx 1) (sub [a,b])) (rid (idx 3) (sub [])) 5, resolv (rid (idx 5) (sub [])) (rid (idx 2) (sub [])) 6, resolv (rid (idx 6) (sub [])) (rid (idx 4) (sub [])) 0] estate)
 (map [
 pr (idx 1) (some (x\ (some y\ ((n(g(x)) &+& n(g(f x y))) &+& n(g(y)))))),
 pr (idx 2) (p (g(a))),
 pr (idx 3) (p (g(f a b))),
 pr (idx 4) (p (g(b))),
 pr (idx 5) (n(g(a)) &+& n(g(b))),
 pr (idx 6) (n(g(b))),
 pr (idx 0) t+]).

