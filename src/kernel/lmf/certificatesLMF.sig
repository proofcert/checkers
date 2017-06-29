% 29 july 2014.
% fake kernel
sig certificatesLMF.
accum_sig lmf-syntax.


type decide_m_ke					cert -> index -> label -> cert -> o.
type release_m_ke 				cert -> cert -> o.

type store_m_kc					cert -> index -> cert -> o.
type initial_m_ke					cert -> index -> o.
type box_m_kc					cert -> label -> (atm -> cert) -> o.
type dia_m_ke					cert -> label -> cert -> o.
type andNeg_m_kc			cert -> cert -> cert -> o.
type orNeg_m_kc 	 				cert -> cert -> o.
type orPos_m_ke    	    			cert -> choice -> cert -> o.
type true_m_ke 					cert -> o.
type false_m_kc 					cert -> cert -> o.
