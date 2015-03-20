module bfol2.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol2"
  (some (x\ (n (g x))) !-! p (g a))
  (rsteps [resolv (rclause 1 (sub [a])) (rclause 2 (sub [])) 0])
  (map [pr 1 (some (x\ (n (g x)))),
   pr 2 (p (g a)),
   pr 0 t+]).

