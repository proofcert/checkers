
type theory =
  | FOF
  | CNF
  | THF
  | TFF
  | TPI

(* Same name as lexer for simplicity *)
type inference =
  | AXIOM               (* from file *)
  | CONJECTURE          (* from file *)
  | DONE                (* last step, does nothing *)
  | ER                  (* equality resolution *)
  | PM                  (* paramodulation *)
  | SPM                 (* simultaneous paramodulation *)
  | EF                  (* equality factoring *)
  | APPLY_DEF           (* replace a complex formula by a single literal *)
  | INTRODUCED_DEF      (* introduce a new definition *)
  | RW                  (* rewriting *)
  | SR                  (* simplify-reflect *)
  | CSR                 (* contextual simplify-reflect *)
  | AR                  (* AC-resolution *)
  | CN                  (* clause normalize (delete trivial and repeated literals *)
  | CONDENSE            (* apply condensation *)
  | ASSUME_NEGATION     (* negate a conjecture - proof by refutation *)
  | FOF_NNF             (* convert to negation normal form *)
  | SHIFT_QUANTORS      (* move quantifiers *)
  | VARIABLE_RENAME     (* rename bound variables *)
  | SKOLEMIZE           (* eliminate existential quantifiers *)
  | DISTRIBUTE          (* move ^ outwards over v *)
  | SPLIT_CONJUNCT      (* make a clause from one conjunct from a CNF formula *)
  | SPLIT_EQUIV         (* ?? *)
  | FOF_SIMPLIFICATION  (* standard simplification steps: replace <=, xor, etc *)

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
  | SPLIT_EQUIV -> "split_equiv"
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
    functions: (string, int) Hashtbl.t;
    predicates: (string, int) Hashtbl.t
  }

  let create () = {
    nodes = Hashtbl.create 100;
    functions = Hashtbl.create 100;
    predicates = Hashtbl.create 100
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

  let set_function dag name arity = Hashtbl.remove dag.functions name; Hashtbl.add dag.functions name arity

  let set_predicate dag name arity = Hashtbl.remove dag.predicates name; Hashtbl.add dag.predicates name arity

  let get_functions dag = dag.functions

  let get_predicates dag = dag.predicates

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

  let add_leaf l lst = match List.mem l !lst with
    | true -> ()
    | false -> lst := l :: !lst
  in
  
  let index_clause f = match Hashtbl.mem map f with
    | true -> Hashtbl.find map f
    | false -> Hashtbl.add map f !i; i := !i + 1; (!i - 1)
  in

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
        let _ = index_clause f in
        add_leaf f leaf_clauses;
        ""
      (* Binary inferences *)
      (* Paramodulation and rewrite occur in the resolution proof *)
      | PM | RW ->
        assert (List.length parents == 2);
        let i = index_clause f in
        let idx = string_of_int i in
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
        let _ = index_clause f in
        add_leaf f leaf_clauses;
        ""
      (* Clause normalization occurs in the resolution proof *)
      | CN ->
        assert (List.length parents == 1);
        let i = index_clause f in
        let idx = string_of_int i in
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
      | r -> print_endline ("Certificate not specified for this inference: " ^ string_of_inference r); exit 5
    end
    | DAG.Empty -> ""
  in

  let last = DAG.find_last dag in
  let steps = printCert_ last in
  let leaves = List.map (fun f -> "(pr " ^ (string_of_int (Hashtbl.find map f)) ^ " " ^ f ^ " )"  ) !leaf_clauses in
  let indexed_clauses = String.concat ",\n" leaves in
  let lst_map = Hashtbl.fold (fun form idx acc -> ("pr " ^ string_of_int idx ^ " " ^ form) :: acc) map [] in
  let pr_map = String.concat ",\n" lst_map in
  let in_sig_f = Hashtbl.fold (fun f ar s -> match ar with
    | 0 -> s
    | n -> (s ^ "inSig " ^ f ^ ".\n")
  ) (DAG.get_functions dag) "\n\n" in
  let in_sig_p = Hashtbl.fold (fun p ar s -> match ar with
    | 0 -> s
    | n -> (s ^ "inSig " ^ p ^ ".\n")
  ) (DAG.get_predicates dag) "\n\n" in
  "module " ^ mod_name ^ ".\n\n" ^
  "accumulate lkf-kernel.\n" ^
  "accumulate eprover.\n" ^
  "accumulate resolution_steps.\n\n" ^
  "resProblem \"" ^ mod_name ^ "\" [" ^ indexed_clauses ^ "] \n(resteps [" ^ steps ^ "])\n (map [\n" ^ pr_map ^ "\n])." ^
  in_sig_f ^ in_sig_p

let printCertSig dag mod_name =
  let rec toTypeString arity pred = match arity with
    | 0 -> begin match pred with
      | true -> "o"
      | false -> "i"
    end
    | n -> "i -> " ^ toTypeString (n-1) pred
  in
  let types_f = Hashtbl.fold (fun name arity acc ->
    "type " ^ name ^ " " ^ (toTypeString arity false) ^ ".\n" ^ acc
  ) (DAG.get_functions dag) "\n" in
  let types_p = Hashtbl.fold (fun name arity acc ->
    "type " ^ name ^ " " ^ (toTypeString arity true) ^ ".\n" ^ acc
  ) (DAG.get_predicates dag) "\n" in
  "sig " ^ mod_name ^ ".\n\n" ^
  "accum_sig lkf-kernel.\n" ^
  "accum_sig eprover.\n" ^
  "accum_sig resolution_steps.\n" ^
  "accum_sig binary_res_fol_nosub.\n" ^
  "accum_sig paramodulation.\n" ^
  "accum_sig base.\n" ^
  "accum_sig lkf-syntax.\n\n" ^ types_f ^ types_p


