% 29 july 2014.
% fake kernel
sig certificatesOS.
accum_sig lmf-syntax.

type initial_os_ke					cert -> index -> o.
type andNeg_os_kc			cert -> cert -> cert -> o.
type orNeg_os_kc 	 				cert -> cert -> o.

type decide_os_ke					cert -> index -> atm -> cert -> o.
type release_os_ke 				cert -> cert -> o.

type storeOs_kc					cert -> index -> cert -> o.
type box_os_kc					cert -> atm -> (atm -> cert) -> o.
type dia_os_ke					cert -> atm -> cert -> o.
type orPos_os_ke    	    			cert -> choice -> cert -> o.
type true_os_ke 					cert -> o.
type false_os_kc 					cert -> cert -> o.
