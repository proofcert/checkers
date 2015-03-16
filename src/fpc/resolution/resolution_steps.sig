sig resolution_steps.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig runner.

kind rstep type.
kind resolv type.
kind rclause type.

type resolv rclause -> rclause -> int -> resolv.
type rsteps list resolv -> cert.

type dlist rclause -> rclause -> cert.

