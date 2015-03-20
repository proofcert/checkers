module bprop3.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop3"
((p a &+& p b) !-!
  (n a &+& p b) !-!
	(p a &+& n b) !-!
	(n a &+& n b))
 	(rsteps [resolv (rclause 1) (rclause 2) 5, resolv (rclause 3) (rclause 4) 6, resolv (rclause 5) (rclause 6) 0])
  (map [pr 1 (p a &+& p b),
   pr 2 (n a &+& p b),
   pr 3 (p a &+& n b),
   pr 4 (n a &+& n b),
   pr 5 (p b),
   pr 6 (n b),
   pr 0 t+]).
