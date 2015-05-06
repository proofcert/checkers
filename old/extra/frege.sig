sig frege.
accum_sig ljf-kernel.                                                                      
kind step type.
kind objF type.
/* Syntax of object formulas */
type $>      	    	     objF -> objF -> objF.
infixr $> 5.
type oa,ob,oc,od     	     objF.
type inst 		     int -> list objF -> int -> step.
type mp			     int -> int -> int -> int -> step.

/* Syntax of formulas*/
type frg		     objF -> atm.

/* Bureau */ 
/*
 It goes 
   - inst AxIndx Instanciations ResIndx
   - mp   RuleIndx LeftPremIndx RightPremIndx Instanciations ResIndx.
*/
type frgC		     list step -> cert.
type endCert		     cert.
type idf		     int -> index.
type wit 		     list objF -> cert -> cert.
type strC		     int -> cert -> cert.
type mpC		     cert ->  cert -> cert.
type antC		     cert -> cert -> cert.
type endWith 		     int -> cert.
/* Payload */
type gam		    int -> form -> o.

/* Utils*/
type testfrg		    int -> o.
type eg			    int -> list int -> cert -> form -> o.
type storeInit		    list int -> cert -> form -> o.
