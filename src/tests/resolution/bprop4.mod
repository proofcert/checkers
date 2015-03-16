module bprop4.

accumulate binary_res_prop.
accumulate resolution_steps.

problem "bprop4"
((p a &+& p b &+& n c) !-!
 (n a &+& p b) !-!
 (p a &+& n b &+& n c) !-!
 (n a &+& n b) !-!
 (p c))
 (rsteps [resolv (rclause 1) (rclause 2) 6, resolv (rclause 3) (rclause 4) 7, resolv (rclause 6) (rclause 7) 8, resolv (rclause 5) (rclause 8) 0])
 (map [pr 1 (p a &+& p b &+& n c),
   pr 2 (n a &+& p b),
   pr 3 (p a &+& n b &+& n c),
   pr 4 (n a &+& n b),
   pr 5 (p c),
   pr 6 (p b &+& n c),
   pr 7 (n b &+& n c),
   pr 8 (n c),
   pr 0 t+]).
