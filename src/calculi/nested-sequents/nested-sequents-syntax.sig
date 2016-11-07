sig nested-sequents-syntax.

accum_sig base.
accum_sig lkf-syntax.
accum_sig modal-syntax.

kind nested-seq-node type.
kind nested-seq type.

type nested-seq-node list index -> nested-seq-node.
type nested-seq nested-seq-node -> list nested-seq -> nested-seq.
