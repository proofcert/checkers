module bprop2.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop2"
	(p a !-! n a)
  (rsteps [resolv (rid (idx 1)) (rid (idx 2)) 0] estate)
  (map [pr 1 (p a),
   pr 2 (n a),
   pr 0 t+]).

