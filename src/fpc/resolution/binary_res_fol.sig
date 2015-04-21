sig binary_res_fol.

accum_sig resolution_steps.
accum_sig res_base.
accum_sig lists.
accum_sig certificatesLKF.

% Substitutions are denoted as a list of atm since they are applied to abstractions in prefix form).
% If the term is (some x\ (some y\ (x + y))) then the first atm replaces x and the second replaces y.
kind sub type.
type sub list atm -> sub.

type rclause int -> sub -> rclause.
type dlist2 rclause -> sub -> cert.
type dlist3 sub -> cert.
