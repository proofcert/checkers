module bfol3.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol3"
 ((some (x\ (some y\ (n(g(x)) &+& n(g(f x y))) &+& n(g(y))))) !-!
  (p (g(a))) !-!
  (p (g(f a b))) !-!
  (p (g(b))))
 (rsteps [resolv (rclause 1 (sub [a,b])) (rclause 3 (sub [])) 5, resolv (rclause 5 (sub [])) (rclause 2 (sub [])) 6, resolv (rclause 6 (sub [])) (rclause 4 (sub [])) 0])
 (map [
 pr 1 (some (x\ (some y\ ((n(g(x)) &+& n(g(f x y))) &+& n(g(y)))))),
 pr 2 (p (g(a))),
 pr 3 (p (g(f a b))),
 pr 4 (p (g(b))),
 pr 5 (n(g(a)) &+& n(g(b))),
 pr 6 (n(g(b))),
 pr 0 t+]).

