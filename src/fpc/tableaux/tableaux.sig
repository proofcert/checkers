sig tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind tab type.
kind infer type.
kind closures type.
kind tuple type.


type assoc A -> A -> tuple.
type back index -> list index -> tuple.
type tabp list infer -> list closures -> list tuple -> list tuple -> cert.
type idx int -> index. 
type delta index -> atm -> index -> infer.
type alpha index -> index -> index -> infer.
type gamma index -> index -> infer.
type beta index -> index -> index -> infer.
type closure index -> index -> list atm -> closures.
type replace_form form -> list tuple -> form -> o.
type replace_back_form form -> list tuple -> form -> o.
type replace atm -> list tuple -> atm -> o.
type replace_back atm -> list tuple -> atm -> o.
type replace_rec list atm -> list tuple -> list atm -> o.
type move_to_front list infer -> index -> list infer -> o.
type elim list infer -> index -> list infer -> o.
type mapsto_smart int -> form -> list tuple -> o.

type signature atm -> atm -> list atm -> list atm -> o. 
