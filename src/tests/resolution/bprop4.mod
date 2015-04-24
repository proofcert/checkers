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
 (map [pr 1 (p a &+& p b &+& n c),
   pr 2 (n a &+& p b),
   pr 3 (p a &+& n b &+& n c),
   pr 4 (n a &+& n b),
   pr 5 (p c),
   pr 6 (p b &+& n c),
   pr 7 (n b &+& n c),
   pr 8 (n c),
   pr 0 t+]).
