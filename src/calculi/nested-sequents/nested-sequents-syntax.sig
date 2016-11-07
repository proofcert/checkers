sig nested-sequents-syntax.

accum_sig base.
accum_sig lkf-syntax.
accum_sig modal-syntax.

kind nested_seq, nested_seq_node type.
type nested_seq_node list index -> nested_seq_node.
type nested_seq nested_seq_node -> list nested_seq ->nested_seq.
