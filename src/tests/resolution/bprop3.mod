module bprop3.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop3"
((p a &+& p b) !-!
  (n a &+& p b) !-!
	(p a &+& n b) !-!
	(n a &+& n b))
 	(rsteps [resolv (rid (idx 1)) (rid (idx 2)) 5, resolv (rid (idx 3)) (rid (idx 4)) 6, resolv (rid (idx 5)) (rid (idx 6)) 0] estate)
  (map [
   pr (idx 1) (p a &+& p b),
   pr (idx 2) (n a &+& p b),
   pr (idx 3) (p a &+& n b),
   pr (idx 4) (n a &+& n b),
   pr (idx 5) (p b),
   pr (idx 6) (n b),
   pr (idx 0) t+]).
