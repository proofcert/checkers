sig lkf-kernel.
accum_sig lkf-certificates.

type lkf_entry      cert -> form -> o.

/* sequents */
kind seq                         type.
type unf             list form -> seq.
type foc                  form -> seq.
type check           cert -> seq -> o.
type storage       index -> form -> o.
/* end */
