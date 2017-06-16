module bprop1.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop1"
  ((n r1 &+& n r2) !-!
  (p r1 &+& n r2) !-!
	(p r2))
	(rsteps [resolv (rid (idx 1)) (rid (idx 2)) 4, resolv (rid (idx 3)) (rid (idx 4)) 0] estate)
  (map [
   pr (idx 1) (n r1 &+& n r2),
   pr (idx 2) (p r1 &+& n r2),
   pr (idx 3) (p r2),
   pr (idx 4) (n r2),
   pr (idx 0) t+]).

