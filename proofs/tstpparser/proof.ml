
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
    mutable terms: string list
  }

  let create () = { nodes = Hashtbl.create 100; terms = [] }

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

  let registerTerm dag name = match List.mem name dag.terms with
    | true -> ()
    | false -> dag.terms <- (name :: dag.terms)

  let get_terms dag = dag.terms

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

let printCert dag =
  let map = Hashtbl.create 100 in
  let i = ref 0 in

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
      | AXIOM | CONJECTURE ->
	assert (List.length parents == 0);
	Hashtbl.add map f !i;
	i := !i + 1; ""
      (* Binary inferences *)
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
      | CN | SPLIT_CONJUNCT | FOF_SIMPLIFICATION | ASSUME_NEGATION | VARIABLE_RENAME ->
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
  let formula = DAG.get_proved_formula dag in 
  let steps = printCert_ last in
  let lst_map = Hashtbl.fold (fun form idx acc -> ("pr " ^ string_of_int idx ^ " " ^ form) :: acc) map [] in
  let pr_map = String.concat ",\n" lst_map in
  let in_sig = List.fold_left (fun s term -> (s ^ "inSig " ^ term ^ ".\n")) "\n\n" (DAG.get_terms dag) in
  "module eprover.\n\n" ^ 
  "accumulate lkf-kernel.\n" ^ 
  "accumulate eprover.\n" ^
  "accumulate resolution_steps.\n\n" ^
  "problem \"eprover\" (" ^ formula ^ ") \n(rsteps [" ^ steps ^ "] estate)\n (map [\n" ^ pr_map ^ "\n])." ^
  in_sig


