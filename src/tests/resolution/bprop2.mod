module bprop2.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop2"
	(p a !-! n a)
  (rsteps [resolv (rclause 1) (rclause 2) 0])
  (map [pr 1 (p a),
   pr 2 (n a),
   pr 0 t+]).

