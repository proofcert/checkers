module bprop1.

accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop1"
  ((n r1 &+& n r2) !-!
  (p r1 &+& n r2) !-!
	(p r2))
	(rsteps [resolv (rclause 1) (rclause 2) 4, resolv (rclause 3) (rclause 4) 0])
  (map [pr 1 (n r1 &+& n r2),
   pr 2 (p r1 &+& n r2),
   pr 3 (p r2),
   pr 4 (n r2),
   pr 0 t+]).

