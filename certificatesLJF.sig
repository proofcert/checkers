% 29 july 2014.
sig certificatesLJF.
accum_sig ljf-syntax, debug.


type decideL_je					cert -> index -> cert -> o.
type decideR_je, releaseL_je, releaseR_je 		cert -> cert -> o.
     
type storeL_jc					cert -> form -> index -> cert -> o.
type storeR_jc					cert -> form -> cert -> o.
type initialL_je					cert -> o.
type initialR_je					cert -> index -> o.
type some_jc, all_jc					cert -> (A -> cert) -> o.
type some_je, all_je					cert -> A -> cert -> o.
type arr_jc, andPos_jc                    cert -> form -> cert -> o.
type or_jc, andNeg_jc, arr_je, andPos_je	cert -> form -> cert -> cert -> o.
type or_je, andNeg_je   	    			cert -> form -> choice -> cert -> o.
type true_je 					cert -> o.
type true_jc 					cert -> cert -> o.
type d+_je, d+_jc, d-_je, d-_jc			cert -> cert -> o.
type cut_je cert -> form -> cert -> cert -> o.
