module bfol1.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol1"
  (n (g a) !-!
   p (g (h (h (a)))) !-!
   some (x\ (p (g (x))) &+& (n (g (h (x))))))
	(rsteps [resolv (rid (idx 1) (sub [])) (rid (idx 3) (sub [a])) 4, resolv (rid (idx 3) (sub [h (a)])) (rid (idx 4) (sub [])) 5, resolv (rid (idx 2) (sub [])) (rid (idx 5) (sub [])) 0] estate)
  (map [
pr (idx 1) (n (g a)),
   pr (idx 2) (p (g (h (h (a))))),
   pr (idx 3) (some (x\ (p (g (x))) &+& (n (g (h (x)))))),
   pr (idx 4) (n (g (h (a)))),
   pr (idx 5) (n (g (h (h (a))))),
   pr (idx 0) t+]).

