sig labeled.

accum_sig lists.
accum_sig certificatesLKF.
accum_sig lkf-syntax.
accum_sig lkf-kernel.
accum_sig debug.

%type q,r,s atm.
kind term type.
type w,w1,w2 term.
type q term -> atm.

type labcheck form -> (list form) -> o.

type labcert list form -> cert.
type labindex form -> index.

% type dlist2 rclause -> sub -> cert.
% type dlist3 sub -> cert.

