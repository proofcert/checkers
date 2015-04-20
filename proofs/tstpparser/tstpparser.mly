
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

(* Same name as lexer for simplicity *)
type inference = 
  | AXIOM		(* from file *)
  | CONJECTURE		(* from file *)
  | ER			(* equality resolution *)
  | PM			(* paramodulation *)
  | SPM			(* simultaneous paramodulation *)
  | EF			(* equality factoring *)
  | APPLY_DEF		(* replace a complex formula by a single literal *)
  | INTRODUCED_DEF	(* introduce a new definition *)
  | RW			(* rewriting *)
  | SR			(* simplify-reflect *)
  | CSR			(* contextual simplify-reflect *)
  | AR			(* AC-resolution *)
  | CN			(* clause normalize (delete trivial and repeated literals *)
  | CONDENSE		(* apply condensation *)
  | ASSUME_NEGATION	(* negate a conjecture - proof by refutation *)
  | FOF_NNF		(* convert to negation normal form *)
  | SHIFT_QUANTORS	(* move quantifiers *) 
  | VARIABLE_RENAME	(* rename bound variables *)
  | SKOLEMIZE		(* eliminate existential quantifiers *)
  | DISTRIBUTE		(* move ^ outwards over v *)
  | SPLIT_CONJUNCT	(* make a clause from one conjunct from a CNF formula *)
  | FOF_SIMPLIFICATION	(* standard simplification steps: replace <=, xor, etc *)

module DAG = struct

  type formula = string

  (* Inference used, name of clause, formula *)
  type info = inference * string * formula

  type dag =
    | Empty
    (* parents, inference used, name of clause, formula, children *)
    | Node of dag list * info * dag list

  type t = { nodes: (string, dag) Hashtbl.t }

  let create () = { nodes = Hashtbl.create 100 }

  let add_kid dag mom_node kid_node = match mom_node with
    | Node( prts, (inf, name, f), kids ) -> 
      let new_mom_node = Node( prts, (inf, name, f), kid_node::kids ) in 
      Hashtbl.replace dag.nodes name new_mom_node 
    | Empty -> failwith ("Cannot add children to the empty dag.")

  let insert dag name formula inf parents = 
    (* Collects the parent nodes *)
    let prt_nodes = List.map (fun p -> Hashtbl.find dag.nodes p) parents in
    (* Creates new node *)
    let node = Node( prt_nodes, (inf, name, formula), []) in
    (* Updates the children of the parents *)
    List.iter (fun p -> add_kid dag p node) prt_nodes;
    (* Adds the new node to the node hash *)
    Hashtbl.add dag.nodes name node

  (* Finds the last node, the one with no kids (this should be unique) *)
  let find_last dag = 
    let sinks = Hashtbl.fold (fun name node acc -> match node with
      | Node(_, _, []) -> node :: acc
      | _ -> acc
    ) dag.nodes [] in
    match sinks with 
      | [] -> failwith "No last node?"
      | n :: [] -> n
      | _ -> failwith "More than one last node?"

end;;

let proof_dag = DAG.create ()

%}

%token THF TFF FOF CNF TPI
%token AXIOM CONJECTURE NEG_CONJECTURE PLAIN
%token ER PM SPM EF APPLY_DEF INTRODUCED_DEF RW SR CSR AR CN 
       CONDENSE ASSUME_NEGATION FOF_NNF SHIFT_QUANTORS VARIABLE_RENAME
       SKOLEMIZE DISTRIBUTE SPLIT_CONJUNCT FOF_SIMPLIFICATION	
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
    | FOF | CNF -> 
      let name = $3 in
      let formula = $7 in
      let (inference, parents) = match $9 with
	| (AXIOM, []) -> if $5 == "axiom" then (AXIOM, [])
	  else if $5 == "conjecture" then (CONJECTURE, [])
	  else failwith ("Unexpected role: \'" ^ $5 ^ "\' for leaf.")
	| _ -> $9
      in
      DAG.insert proof_dag name formula inference parents;
      "\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nParents: " ^ List.fold_left (fun acc p -> p ^ ", " ^ acc) "" parents
    | _ -> failwith ("Unsupported theory: " ^ (theoryToString $1))
}
/* The last inference seems to have one extra argument */
| theory LPAREN name COMMA role COMMA formula COMMA annotation COMMA LBRACKET WORD RBRACKET RPAREN DOT {
  match $1 with
    | FOF | CNF -> 
      let name = $3 in
      let formula = $7 in
      let (inference, parents) = match $9 with
	| (AXIOM, []) -> if $5 == "axiom" then (AXIOM, [])
	  else if $5 == "conjecture" then (CONJECTURE, [])
	  else failwith ("Unexpected role: \'" ^ $5 ^ "\' for leaf.")
	| _ -> $9
      in
      DAG.insert proof_dag name formula inference parents;
      "\nLAST RULE\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nParents: " ^ List.fold_left (fun acc p -> p ^ ", " ^ acc) "" parents
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
| file_info 	 { (AXIOM, []) }
| inference_info { $1 }

file_info:
| FILE LPAREN FILEPATH COMMA name RPAREN { "" }

inference_info:
| INFERENCE LPAREN inf_name COMMA status COMMA antecedents RPAREN {
  ($3, $7)
}

inf_name:
| ER 			{ ER }
| PM			{ PM }
| SPM			{ SPM }
| EF			{ EF }
| APPLY_DEF		{ APPLY_DEF }
| INTRODUCED_DEF	{ INTRODUCED_DEF }
| RW			{ RW }
| SR			{ SR }
| CSR			{ CSR }
| AR			{ AR }
| CN			{ CN }
| CONDENSE		{ CONDENSE }
| ASSUME_NEGATION	{ ASSUME_NEGATION }
| FOF_NNF		{ FOF_NNF }
| SHIFT_QUANTORS	{ SHIFT_QUANTORS }
| VARIABLE_RENAME	{ VARIABLE_RENAME }
| SKOLEMIZE		{ SKOLEMIZE }
| DISTRIBUTE		{ DISTRIBUTE }
| SPLIT_CONJUNCT	{ SPLIT_CONJUNCT }
| FOF_SIMPLIFICATION	{ FOF_SIMPLIFICATION }

/* Ignoring the status for now */
status:
| LBRACKET STATUS LPAREN status_type RPAREN RBRACKET { "" }

status_type:
| THM { "thm" }
| CTH { "cth" }

/* It looks like e-prover specifies always at most 2 antecedents */
antecedents:
| LBRACKET ant RBRACKET		  { $2 }
| LBRACKET ant COMMA ant RBRACKET { $2 @ $4 }

ant:
| name		 { [$1] }
| inference_info { match $1 with (_, ant) -> ant }

