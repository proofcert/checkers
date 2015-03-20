module bfol1.

accumulate lkf-kernel.
accumulate binary_res_fol.
accumulate resolution_steps.

problem "bfol1"
  (n (g a) !-!
   p (g (h (h (a)))) !-!
   some (x\ (p (g (x))) &+& (n (g (h (x))))))
	(rsteps [resolv (rclause 1 (sub [])) (rclause 3 (sub [a])) 4, resolv (rclause 3 (sub [h (a)])) (rclause 4 (sub [])) 5, resolv (rclause 2 (sub [])) (rclause 5 (sub [])) 0])
  (map [pr 1 (n (g a)),
   pr 2 (p (g (h (h (a))))),
   pr 3 (some (x\ (p (g (x))) &+& (n (g (h (x)))))),
   pr 4 (n (g (h (a)))),
   pr 5 (n (g (h (h (a))))),
   pr 0 t+]).

