sig eprover.

accum_sig resolution_steps.
accum_sig binary_res_fol_nosub.
accum_sig paramodulation.
accum_sig lists.
accum_sig certificatesLKF.

% constructor for rclause
type id index -> rclause.

type varmaps list (list int) -> state. % the hd index is the original and all others in the list should be mapped to it

type varmap int -> int -> list (list int) -> list (list int) -> o.
type varmapped int -> int -> list (list int) -> o.

% unary rules
type assume_negation,
     fof_simplification,
     split_conjunct,
     variable_rename,
     cn
 rclause -> int -> resolv.

type unary_rule resolv -> int -> int -> o.
type param_rule resolv -> int -> int -> int -> o.

% binary rules
type pm,
     rw
 rclause -> rclause -> int -> resolv.

