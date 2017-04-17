module bprop4.

accumulate lkf-kernel.
accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop4"
((p a &+& p b &+& n c) !-!
 (n a &+& p b) !-!
 (p a &+& n b &+& n c) !-!
 (n a &+& n b) !-!
 (p c))
 (rsteps [resolv (rid (idx 1)) (rid (idx 2)) 6, resolv (rid (idx 3)) (rid (idx 4)) 7, resolv (rid (idx 6)) (rid (idx 7)) 8, resolv (rid (idx 5)) (rid (idx 8)) 0] estate)
 (map [
pr (idx 1) (p a &+& p b &+& n c),
   pr (idx 2) (n a &+& p b),
   pr (idx 3) (p a &+& n b &+& n c),
   pr (idx 4) (n a &+& n b),
   pr (idx 5) (p c),
   pr (idx 6) (p b &+& n c),
   pr (idx 7) (n b &+& n c),
   pr (idx 8) (n c),
   pr (idx 0) t+]).
