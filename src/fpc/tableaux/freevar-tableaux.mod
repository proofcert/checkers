module freevar-tableaux.

accumulate fittings-tableaux.

decide_ke (fvtabcert L1 L2) I R :- listsToTree L1 L2 T, decide_ke (fitcert [] T []) I R.
store_kc (fvtabcert L1 L2) Form H R :- listsToTree L1 L2 T, store_kc (fitcert [] T []) Form H R.
release_ke (fvtabcert L1 L2) R :- listsToTree L1 L2 T, release_ke (fitcert [] T []) R.
initial_ke (fvtabcert L1 L2) R :- listsToTree L1 L2 T, initial_ke (fitcert [] T []) R.
orNeg_kc (fvtabcert L1 L2) Form R :- listsToTree L1 L2 T, orNeg_kc (fitcert [] T []) Form R.
andNeg_kc (fvtabcert L1 L2) Form R1 R2 :- listsToTree L1 L2 T, andNeg_kc (fitcert [] T []) Form R1 R2.
andPos_k (fvtabcert L1 L2) Form Dir R1 R2 :- listsToTree L1 L2 T, andPos_k (fitcert [] T []) Form Dir R1 R2.
all_kc (fvtabcert L1 L2) R :- listsToTree L1 L2 T, all_kc (fitcert [] T []) R.
some_ke (fvtabcert L1 L2) X R :- listsToTree L1 L2 T, some_ke (fitcert [] T []) X R.

listsToTree L1 L2 T.
