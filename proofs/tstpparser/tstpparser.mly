
%{
open Proof
open Str

let getNumArgs arg_str =
  let rec count lst paren = match lst with
    | [] -> 0
    | hd :: tl -> begin
      if hd = "(" then count tl (paren + 1)
      else if hd = ")" then begin
  if paren = 1 then ( 1 + (count tl 0) )
  else ( count tl (paren - 1) )
      end
      else begin
  if paren = 0 then 1 + count tl 0
  else count tl paren
      end
    end
  in
  let str_lst = Str.split (regexp " ") arg_str in
  count str_lst 0

let theoryToString thr = match thr with
  | FOF -> "fof"
  | CNF -> "cnf"
  | THF -> "thf"
  | TFF -> "tff"
  | TPI -> "tpi"

let proof_dag = DAG.create () ;;

%}

%token THF TFF FOF CNF TPI
%token AXIOM CONJECTURE NEG_CONJECTURE PLAIN
%token ER PM SPM EF APPLY_DEF INTRODUCED_DEF RW SR CSR AR CN
       CONDENSE ASSUME_NEGATION FOF_NNF SHIFT_QUANTORS VARIABLE_RENAME
       SKOLEMIZE DISTRIBUTE SPLIT_CONJUNCT SPLIT_EQUIV FOF_SIMPLIFICATION TH_EQ TH_EQ_S
%token <string> ATOM
%token FILE INFERENCE STATUS
       OR NOT AND IMP BIMP FORALL EXISTS EQ NEQ FALSE TRUE
       LPAREN RPAREN COMMA DOT COLON LBRACKET RBRACKET
       FILEPATH
       THM CTH
%token <string> WORD VAR
%token <int> INTEGER

%start proof /* the entry point */
%type <Proof.DAG.t> proof

%%

proof:
| theory LPAREN name COMMA role COMMA formula COMMA annotation RPAREN DOT {
  match $1 with
    | FOF | CNF ->
      let name = $3 in
      let formula = $7 in
      let (inference, parents) = match $9 with
        | (AXIOM, []) -> if $5 = "axiom" then (AXIOM, [])
          else if $5 = "conjecture" then (CONJECTURE, [])
          else failwith ("Unexpected role: \'" ^ $5 ^ "\' for leaf.")
        | (INTRODUCED_DEF, []) -> (AXIOM, [])
        | _ -> $9
      in
      (*print_string ("\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nParents: " ^ List.fold_left (fun acc p -> p ^ ", " ^ acc) "" parents);*)
      DAG.insert proof_dag name formula inference parents;
      proof_dag
    | _ -> failwith ("Unsupported theory: " ^ (theoryToString $1))
}
/* The last inference seems to have one extra argument */
| theory LPAREN name COMMA role COMMA formula COMMA annotation COMMA LBRACKET WORD RBRACKET RPAREN DOT {
  match $1 with
    | FOF | CNF ->
      let name = $3 in
      let formula = $7 in
      let (inference, parents) = match $9 with
        | (AXIOM, []) -> if $5 = "axiom" then (AXIOM, [])
          else if $5 = "conjecture" then (CONJECTURE, [])
          else failwith ("Unexpected role: \'" ^ $5 ^ "\' for leaf.")
        | (INTRODUCED_DEF, []) -> (AXIOM, [])
        | _ -> $9
      in
      (*print_string ("\nLAST RULE\nName: " ^ $3 ^ "\nRole: " ^ $5 ^ "\nFormula: " ^ $7 ^ "\nParents: " ^ List.fold_left (fun acc p -> p ^ ", " ^ acc) "" parents);*)
      DAG.insert proof_dag name formula inference parents;
      proof_dag
    | _ -> failwith ("Unsupported theory: " ^ (theoryToString $1))
}

theory:
| FOF { FOF }
| CNF { CNF }
| THF { THF }
| TFF { TFF }
| TPI { TPI }

name:
| WORD    { $1 }
| INTEGER { string_of_int $1 }

role:
| AXIOM          { "axiom" }
| CONJECTURE     { "conjecture" }
| NEG_CONJECTURE { "neg_conjecture" }
| PLAIN          { "plain" }

/* TODO: explain properly why we negate the formulas */
formula:
| LPAREN formula RPAREN { $2 }
| atom                  { $1 }
| formula AND formula   { $1 ^ " &+& " ^ $3 }
| formula OR formula    { $1 ^ " !-! " ^ $3 }
/* NOTE: the following three translations are wrong. These clauses should not be used. */
| formula IMP formula   { " unsupported " }
| formula BIMP formula  { " unsupported " }
| NOT formula           { " unsupported " }
| FORALL LBRACKET var RBRACKET COLON formula   { "(all (" ^ $3 ^ "\\ " ^ $6 ^ ")) " }
| EXISTS LBRACKET var RBRACKET COLON formula   { "(some (" ^ $3 ^ "\\ " ^ $6 ^ ")) " }
| FALSE                 { "f-" }
| TRUE                  { "t+" }

atom:
| LPAREN atom RPAREN { $2 }
| pos_atom           { "(p " ^ $1 ^ ")" }
| neg_atom           { "(n " ^ $1 ^ ")" }

neg_atom:
| term NEQ term                  { "(" ^ $1 ^ " == " ^ $3 ^ ")" }
| NOT LPAREN term EQ term RPAREN { "(" ^ $3 ^ " == " ^ $5 ^ ")" }
| NOT WORD LPAREN args RPAREN    { DAG.set_predicate proof_dag $2 (getNumArgs $4); "("  ^ $2 ^ " " ^ $4 ^ ")"}
| NOT WORD                       { DAG.set_predicate proof_dag $2 0; $2 }

pos_atom:
| term EQ term            { "(" ^ $1 ^ " == " ^ $3 ^ ")" }
| WORD LPAREN args RPAREN { DAG.set_predicate proof_dag $1 (getNumArgs $3); "(" ^ $1 ^ " " ^ $3 ^ ")"}
| WORD                    { DAG.set_predicate proof_dag $1 0; $1 }

args:
| term            { $1 }
| term COMMA args { $1 ^ " " ^ $3 }

term:
| VAR         { $1 }
| WORD        { DAG.set_function proof_dag $1 0; $1 }
| WORD LPAREN args RPAREN {
  DAG.set_function proof_dag $1 (getNumArgs $3);
  "( " ^ $1 ^ " " ^ $3 ^ " )" }

/* TODO: policy for variable syntax in the certificates? */
var:
| VAR  { $1 }

annotation:
| file_info      { (AXIOM, []) }
| inference_info { $1 }
| INTRODUCED_DEF { (INTRODUCED_DEF, []) }
| WORD           { (DONE, [$1]) } /* for the last inference in verbose mode */

file_info:
| FILE LPAREN FILEPATH COMMA name RPAREN { "" }

inference_info:
| INFERENCE LPAREN inf_name COMMA status COMMA antecedents RPAREN {
  ($3, $7)
}

inf_name:
| ER                 { ER }
| PM                 { PM }
| SPM                { SPM }
| EF                 { EF }
| APPLY_DEF          { APPLY_DEF }
| RW                 { RW }
| SR                 { SR }
| CSR                { CSR }
| AR                 { AR }
| CN                 { CN }
| CONDENSE           { CONDENSE }
| ASSUME_NEGATION    { ASSUME_NEGATION }
| FOF_NNF            { FOF_NNF }
| SHIFT_QUANTORS     { SHIFT_QUANTORS }
| VARIABLE_RENAME    { VARIABLE_RENAME }
| SKOLEMIZE          { SKOLEMIZE }
| DISTRIBUTE         { DISTRIBUTE }
| SPLIT_CONJUNCT     { SPLIT_CONJUNCT }
| SPLIT_EQUIV        { SPLIT_EQUIV }
| FOF_SIMPLIFICATION { FOF_SIMPLIFICATION }

/* Ignoring the status for now */
status:
| LBRACKET STATUS LPAREN status_type RPAREN RBRACKET { "" }

status_type:
| THM { "thm" }
| CTH { "cth" }

/* It looks like e-prover specifies always at most 2 antecedents */
antecedents:
| LBRACKET antlist RBRACKET { $2 }

antlist:
| ant               { $1 }
| ant COMMA antlist { $1 @ $3 }

ant:
| TH_EQ          { [] }
| TH_EQ_S        { [] }
| name           { [$1] }
| inference_info { match $1 with (_, ant) -> ant }
/* TODO: find out what this means */

