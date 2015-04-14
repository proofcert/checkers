
%{

type theory =
  | FOF
  | CNF
  | THF
  | TFF
  | TPI

(*type role = 
  | AXIOM
  | CONJECTURE
  | NEG_CONGECTURE
  | PLAIN*)

let theoryToString thr = match thr with
  | FOF -> "fof"
  | CNF -> "cnf"
  | THF -> "thf"
  | TFF -> "tff"
  | TPI -> "tpi"

%}

%token THF TFF FOF CNF TPI
%token AXIOM CONJECTURE NEG_CONJECTURE PLAIN
%token <string> ATOM
%token FILE INFERENCE STATUS
       OR NOT AND IMP FALSE TRUE
       LPAREN RPAREN COMMA DOT LBRACKET RBRACKET
       FILEPATH
       THM CTH 
%token <string> WORD
%token <int> INTEGER

%start proof /* the entry point */
%type <string> proof

%%

proof:
| theory LPAREN name COMMA role COMMA formula COMMA annotation RPAREN DOT {
  match $1 with
    | FOF | CNF -> "\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nAnnotation" ^ $9 
    | _ -> failwith ("Unsupported theory: " ^ (theoryToString $1))
}
/* The last inference seems to have one extra argument */
| theory LPAREN name COMMA role COMMA formula COMMA annotation COMMA LBRACKET WORD RBRACKET RPAREN DOT {
  match $1 with
    | FOF | CNF -> "\nLAST RULE\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nAnnotation" ^ $9 
    | _ -> failwith ("Unsupported theory: " ^ (theoryToString $1))
}

theory:
| FOF { FOF }
| CNF { CNF }
| THF { THF }
| TFF { TFF }
| TPI { TPI }

name:
| WORD	  { $1 }
| INTEGER { string_of_int $1 }

role:
| AXIOM		 { "axiom" }
| CONJECTURE	 { "conjecture" }
| NEG_CONJECTURE { "neg_conjecture" }
| PLAIN		 { "plain" }

/* TODO: print the formulas correctly */
formula:
| LPAREN formula RPAREN { $2 }
| NOT formula		{ "n " ^ $2 }
| formula AND formula   { $1 ^ " &+& " ^ $3 }
| formula OR formula	{ $1 ^ " !-! " ^ $3 }
| formula IMP formula	{ $1 ^ " arr " ^ $3 }
| FALSE			{ "f-" }
| TRUE 			{ "t+" }
| atom			{ "p " ^ $1 }

atom:
| WORD LPAREN args RPAREN { $1 ^ "(" ^ $3 ^ ")"}
| WORD 			  { $1 }

args:
| WORD		  { $1 }
| WORD COMMA args { $1 ^ ", " ^ $3 }

annotation: 
| file_info 	 { $1 }
| inference_info { $1 }

file_info:
| FILE LPAREN FILEPATH COMMA name RPAREN { "" }

inference_info:
| INFERENCE LPAREN name COMMA status COMMA antecedents RPAREN {
  "inf: " ^ $3 ^ " on " ^ $7 
}

/* Ignoring the status for now */
status:
| LBRACKET STATUS LPAREN status_type RPAREN RBRACKET { "" }

status_type:
| THM { "thm" }
| CTH { "cth" }

/* It looks like e-prover specifies always at most 2 antecedents */
antecedents:
| LBRACKET ant RBRACKET		  { $2 }
| LBRACKET ant COMMA ant RBRACKET { $2 ^ " and " ^ $4 }

ant:
| name		 { $1 }
| inference_info { $1 }

