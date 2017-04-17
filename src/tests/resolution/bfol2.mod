module bfol2.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol2"
  (some (x\ (n (g x))) !-! p (g a))
  (rsteps [resolv (rid (idx 1) (sub [a])) (rid (idx 2) (sub [])) 0] estate)
  (map [
pr (idx 1) (some (x\ (n (g x)))),
   pr (idx 2) (p (g a)),
   pr (idx 0) t+]).

