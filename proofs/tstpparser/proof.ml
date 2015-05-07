
type theory =
  | FOF
  | CNF
  | THF
  | TFF
  | TPI

(* Same name as lexer for simplicity *)
type inference = 
  | AXIOM		(* from file *)
  | CONJECTURE		(* from file *)
  | DONE		(* last step, does nothing *)
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

let string_of_inference inf = match inf with 
  | AXIOM -> "axiom"
  | CONJECTURE -> "conjecture"
  | DONE -> "proof"
  | ER -> "er"
  | PM -> "pm"
  | SPM -> "spm"
  | EF -> "ef"
  | APPLY_DEF -> "apply_def"
  | INTRODUCED_DEF -> "introduced(definition)"
  | RW -> "rw"
  | SR -> "sr"
  | CSR -> "csr"
  | AR -> "ar"
  | CN -> "cn"
  | CONDENSE -> "condense"
  | ASSUME_NEGATION -> "assume_negation"
  | FOF_NNF -> "fof_nnf"
  | SHIFT_QUANTORS -> "shift_quantors"
  | VARIABLE_RENAME -> "variable_rename"
  | SKOLEMIZE -> "skolemize"
  | DISTRIBUTE -> "distribute"
  | SPLIT_CONJUNCT -> "split_conjunct"
  | FOF_SIMPLIFICATION -> "fof_simplification"

module DAG = struct

  type formula = string

  (* Inference used, name of clause, formula *)
  type info = inference * string * formula

  type dag =
    | Empty
    (* parents, inference used, name of clause, formula, children *)
    | Node of dag list * info * dag list

  type t = { 
    nodes: (string, dag) Hashtbl.t;
    terms: (string, int) Hashtbl.t; (* value is dummy *)
    types: (string, int) Hashtbl.t
  }

  let create () = { 
    nodes = Hashtbl.create 100; 
    terms = Hashtbl.create 100;
    types = Hashtbl.create 100
  }

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

  let registerTerm dag name = Hashtbl.remove dag.terms name; Hashtbl.add dag.terms name 1

  let registerType dag name arity = Hashtbl.remove dag.types name; Hashtbl.add dag.types name arity

  let get_terms dag = Hashtbl.fold (fun k v lst -> k :: lst) dag.terms []
  
  let get_types dag = dag.types

  (* Finds the last node, the one with no kids (this should be unique) *)
  let find_last dag = 
    let sinks = Hashtbl.fold (fun name node acc -> match node with
      (* Workaround since the dag has many sinks (unsuccessful derivations) *)
      | Node(_, (DONE,_,_), []) -> node :: acc
      | _ -> acc
    ) dag.nodes [] in
    match sinks with 
      | [] -> failwith "No last node?"
      | n :: [] -> n
      | _ -> failwith "More than one last node?"

  (* Returns the proved clause in CNF *)
  let get_proved_formula dag = 
    let sources = Hashtbl.fold (fun name node acc -> match node with
      | Node(_, (AXIOM,_,f), _) -> f :: acc
      | Node(_, (ASSUME_NEGATION,_,f), _) -> f :: acc
      | _ -> acc
    ) dag.nodes [] in
    String.concat " !-!\n" sources

end;;

let printCertMod dag mod_name =
  let map = Hashtbl.create 100 in
  let i = ref 0 in
  (* Find a more elegant way to do this *)
  let leaf_clauses = ref [] in

  let printClause node = match node with
    | DAG.Node(_, (_, _, f), _) -> begin
      try match Hashtbl.find map f with
	| n -> "(id (idx " ^ string_of_int n ^ "))"
      with Not_found -> failwith ("Undefined clause: " ^ f)
    end
    | DAG.Empty -> ""
  in

  let rec printCert_ node = match node with
    | DAG.Node( parents, (inf, name, f), _) -> begin match inf with
      (* Inferences handled so far *)
      (* If there is some kind of clausal transformation, this should ideally not be reached *)
      | AXIOM | CONJECTURE ->
	assert (List.length parents == 0);
	Hashtbl.add map f !i;
	leaf_clauses := f :: !leaf_clauses;
	i := !i + 1; ""
      (* Binary inferences *)
      (* Paramodulation and rewrite occur in the resolution proof *)
      | PM | RW ->
	assert (List.length parents == 2);
	Hashtbl.add map f !i;
	let idx = string_of_int !i in
	i := !i + 1;
	let mom = List.nth parents 0 in
	let dad = List.nth parents 1 in
	let momside = printCert_ mom in
	let dadside = printCert_ dad in
	let inf_name = string_of_inference inf in
	if (momside = "") && (dadside = "") then begin
	  (inf_name ^ " " ^ printClause mom ^ " " ^ printClause dad ^ " " ^ idx)
	end else 
	if (momside <> "") && (dadside = "") then begin
	  (momside ^ ", " ^ inf_name ^ " " ^ printClause mom ^ " " ^ printClause dad ^ " " ^ idx)
	end else
	if (momside = "") && (dadside <> "") then begin
	  (dadside ^ ", "  ^ inf_name ^ " " ^ printClause mom ^ " " ^ printClause dad ^ " " ^ idx)
	end else
	if (momside <> "") && (dadside <> "") then begin
	  (momside ^ ", " ^ dadside ^ ", "  ^ inf_name ^ " " ^ printClause mom ^ " " ^ printClause dad ^ " " ^ idx)
	end else
	  failwith "This should have not been reached."
      (* Unary inferences *)
      (* These are considered axioms since we are not checking the clausal normal form translation *)
      | SPLIT_CONJUNCT | FOF_SIMPLIFICATION | ASSUME_NEGATION | VARIABLE_RENAME ->
	assert (List.length parents == 1);
	Hashtbl.add map f !i;
	leaf_clauses := f :: !leaf_clauses;
	i := !i + 1; ""
      (* Clause normalization occurs in the resolution proof *)
      | CN -> 
	assert (List.length parents == 1);
	Hashtbl.add map f !i;
	let idx = string_of_int !i in
	i := !i + 1;
	let mom = List.nth parents 0 in
	let momside = printCert_ mom in
	let inf_name = string_of_inference inf in
	if (momside <> "") then begin
	  (momside ^ ", " ^ inf_name ^ " " ^ printClause mom ^ " " ^ idx)
	end else
	  (inf_name ^ " " ^ printClause mom ^ " " ^ idx)
      (* This is only the last node. *)
      | DONE ->
	assert (List.length parents == 1); 
	printCert_ (List.nth parents 0)
      | r -> failwith ("Certificate not specified for this inference: " ^ string_of_inference r)
    end
    | DAG.Empty -> ""
  in

  let last = DAG.find_last dag in
  let steps = printCert_ last in
  let leaves = List.map (fun f -> "(pr " ^ (string_of_int (Hashtbl.find map f)) ^ " " ^ f ^ " )"  ) !leaf_clauses in
  let indexed_clauses = String.concat ",\n" leaves in
  let lst_map = Hashtbl.fold (fun form idx acc -> ("pr " ^ string_of_int idx ^ " " ^ form) :: acc) map [] in
  let pr_map = String.concat ",\n" lst_map in
  let state_str = " estate " in
  let in_sig = List.fold_left (fun s term -> (s ^ "inSig " ^ term ^ ".\n")) "\n\n" (DAG.get_terms dag) in
  "module " ^ mod_name ^ ".\n\n" ^ 
  "accumulate lkf-kernel.\n" ^ 
  "accumulate eprover.\n" ^
  "accumulate resolution_steps.\n\n" ^
  "problem \"" ^ mod_name ^ "\" [" ^ indexed_clauses ^ "] \n(rsteps [" ^ steps ^ "]" ^ state_str ^ ")\n (map [\n" ^ pr_map ^ "\n])." ^
  in_sig

let printCertSig dag mod_name =
  let rec toTypeString arity = match arity with
    | 0 -> " i"
    | n -> "i -> " ^ toTypeString (n-1)
  in
  let types = Hashtbl.fold (fun name arity acc -> 
    "type " ^ name ^ " " ^ (toTypeString arity) ^ ".\n" ^ acc
  ) (DAG.get_types dag) "" in
  "sig " ^ mod_name ^ ".\n\n" ^
  "accum_sig lkf-kernel.\n" ^
  "accum_sig eprover.\n" ^
  "accum_sig resolution_steps.\n" ^
  "accum_sig binary_res_fol_nosub.\n" ^
  "accum_sig paramodulation.\n" ^
  "accum_sig base.\n" ^
  "accum_sig lkf-syntax.\n\n" ^ types


