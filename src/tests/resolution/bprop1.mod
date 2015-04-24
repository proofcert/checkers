module bprop1.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop1"
  ((n r1 &+& n r2) !-!
  (p r1 &+& n r2) !-!
	(p r2))
	(rsteps [resolv (rid (idx 1)) (rid (idx 2)) 4, resolv (rid (idx 3)) (rid (idx 4)) 0] estate)
  (map [pr 1 (n r1 &+& n r2),
   pr 2 (p r1 &+& n r2),
   pr 3 (p r2),
   pr 4 (n r2),
   pr 0 t+]).

