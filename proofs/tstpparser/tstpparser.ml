type token =
  | THF
  | TFF
  | FOF
  | CNF
  | TPI
  | AXIOM
  | HYPOTHESIS
  | CONJECTURE
  | NEG_CONJECTURE
  | PLAIN
  | ER
  | PM
  | SPM
  | EF
  | APPLY_DEF
  | INTRODUCED_DEF
  | RW
  | SR
  | CSR
  | AR
  | CN
  | CONDENSE
  | ASSUME_NEGATION
  | FOF_NNF
  | SHIFT_QUANTORS
  | VARIABLE_RENAME
  | SKOLEMIZE
  | DISTRIBUTE
  | SPLIT_CONJUNCT
  | SPLIT_EQUIV
  | FOF_SIMPLIFICATION
  | TH_EQ
  | TH_EQ_S
  | ATOM of (string)
  | FILE
  | INFERENCE
  | STATUS
  | OR
  | NOT
  | AND
  | IMP
  | BIMP
  | FORALL
  | EXISTS
  | EQ
  | NEQ
  | FALSE
  | TRUE
  | LPAREN
  | RPAREN
  | COMMA
  | DOT
  | COLON
  | LBRACKET
  | RBRACKET
  | FILEPATH
  | THM
  | CTH
  | WORD of (string)
  | VAR of (string)
  | INTEGER of (int)

open Parsing;;
let _ = parse_error;;
# 3 "tstpparser.mly"
open Proof
open Str

let getNumArgs arg_str =
  let rec count lst paren = match lst with
    | [] -> 0
    | hd :: tl -> begin match hd with
      | Text(_) ->
        if paren = 0 then 1 + count tl 0
        else count tl paren
      | Delim(p) when p = "(" -> count tl (paren + 1)
      | Delim(p) when p = ")" -> 
        if paren = 1 then (1 + count tl 0)
        else (count tl (paren - 1))
      | Delim(s) when s = " " -> count tl paren
      | Delim(d) -> print_endline ("Wrong delimiter: " ^ d); exit 4
    end
  in
  let str_lst = Str.full_split (regexp "[() ]") arg_str in
  count str_lst 0

let add_var v lst = match List.mem v !lst with
  | true -> ()
  | false -> lst := v :: !lst

let theoryToString thr = match thr with
  | FOF -> "fof"
  | CNF -> "cnf"
  | THF -> "thf"
  | TFF -> "tff"
  | TPI -> "tpi"

let proof_dag = DAG.create () ;;

let quantified_vars = ref [] ;;
let used_vars = ref [] ;;

# 105 "tstpparser.ml"
let yytransl_const = [|
  257 (* THF *);
  258 (* TFF *);
  259 (* FOF *);
  260 (* CNF *);
  261 (* TPI *);
  262 (* AXIOM *);
  263 (* HYPOTHESIS *);
  264 (* CONJECTURE *);
  265 (* NEG_CONJECTURE *);
  266 (* PLAIN *);
  267 (* ER *);
  268 (* PM *);
  269 (* SPM *);
  270 (* EF *);
  271 (* APPLY_DEF *);
  272 (* INTRODUCED_DEF *);
  273 (* RW *);
  274 (* SR *);
  275 (* CSR *);
  276 (* AR *);
  277 (* CN *);
  278 (* CONDENSE *);
  279 (* ASSUME_NEGATION *);
  280 (* FOF_NNF *);
  281 (* SHIFT_QUANTORS *);
  282 (* VARIABLE_RENAME *);
  283 (* SKOLEMIZE *);
  284 (* DISTRIBUTE *);
  285 (* SPLIT_CONJUNCT *);
  286 (* SPLIT_EQUIV *);
  287 (* FOF_SIMPLIFICATION *);
  288 (* TH_EQ *);
  289 (* TH_EQ_S *);
  291 (* FILE *);
  292 (* INFERENCE *);
  293 (* STATUS *);
  294 (* OR *);
  295 (* NOT *);
  296 (* AND *);
  297 (* IMP *);
  298 (* BIMP *);
  299 (* FORALL *);
  300 (* EXISTS *);
  301 (* EQ *);
  302 (* NEQ *);
  303 (* FALSE *);
  304 (* TRUE *);
  305 (* LPAREN *);
  306 (* RPAREN *);
  307 (* COMMA *);
  308 (* DOT *);
  309 (* COLON *);
  310 (* LBRACKET *);
  311 (* RBRACKET *);
  312 (* FILEPATH *);
  313 (* THM *);
  314 (* CTH *);
    0|]

let yytransl_block = [|
  290 (* ATOM *);
  315 (* WORD *);
  316 (* VAR *);
  317 (* INTEGER *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\003\000\
\003\000\004\000\004\000\004\000\004\000\004\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\007\000\007\000\
\007\000\010\000\010\000\009\000\012\000\012\000\011\000\011\000\
\011\000\008\000\006\000\006\000\006\000\006\000\013\000\014\000\
\015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\016\000\018\000\018\000\017\000\
\019\000\019\000\020\000\020\000\020\000\020\000\000\000"

let yylen = "\002\000\
\011\000\015\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\003\000\001\000\
\003\000\003\000\006\000\006\000\001\000\001\000\003\000\001\000\
\001\000\003\000\006\000\003\000\001\000\003\000\001\000\001\000\
\004\000\001\000\001\000\001\000\001\000\001\000\006\000\008\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\006\000\001\000\001\000\003\000\
\001\000\003\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\006\000\003\000\004\000\007\000\071\000\
\000\000\000\000\008\000\009\000\000\000\000\000\010\000\011\000\
\012\000\013\000\014\000\000\000\000\000\000\000\000\000\000\000\
\021\000\022\000\000\000\000\000\031\000\000\000\016\000\024\000\
\025\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\034\000\000\000\
\000\000\015\000\023\000\000\000\000\000\000\000\000\000\037\000\
\000\000\000\000\038\000\000\000\035\000\036\000\028\000\026\000\
\000\000\000\000\000\000\000\000\033\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\030\000\000\000\041\000\042\000\
\043\000\044\000\045\000\046\000\047\000\048\000\049\000\050\000\
\051\000\052\000\053\000\054\000\055\000\056\000\057\000\058\000\
\059\000\060\000\000\000\001\000\000\000\027\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\039\000\
\000\000\000\000\000\000\000\000\000\000\000\000\002\000\062\000\
\063\000\000\000\067\000\068\000\069\000\070\000\000\000\000\000\
\040\000\000\000\064\000\000\000\061\000\066\000"

let yydgoto = "\002\000\
\008\000\009\000\125\000\020\000\030\000\060\000\031\000\048\000\
\032\000\033\000\034\000\053\000\061\000\126\000\099\000\110\000\
\118\000\122\000\127\000\128\000"

let yysindex = "\003\000\
\074\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\214\254\215\254\000\000\000\000\219\254\080\255\000\000\000\000\
\000\000\000\000\000\000\235\254\236\254\224\254\233\254\240\254\
\000\000\000\000\236\254\248\254\000\000\034\255\000\000\000\000\
\000\000\221\254\222\254\013\255\013\255\006\255\054\255\222\254\
\236\254\236\254\242\254\222\254\222\254\039\255\000\000\051\255\
\053\255\000\000\000\000\056\255\055\255\042\255\042\255\000\000\
\060\255\061\255\000\000\041\255\000\000\000\000\000\000\000\000\
\222\254\058\255\059\255\222\254\000\000\057\255\040\255\062\255\
\063\255\065\255\236\254\236\254\000\000\067\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\068\255\000\000\064\255\000\000\042\255\042\255\
\215\254\066\255\069\255\071\255\079\255\075\255\072\255\000\000\
\076\255\073\255\077\255\036\255\229\254\078\255\000\000\000\000\
\000\000\081\255\000\000\000\000\000\000\000\000\082\255\083\255\
\000\000\084\255\000\000\229\254\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\253\254\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\043\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\085\255\000\000\046\255\048\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\050\255\052\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\086\255\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\246\255\000\000\230\255\000\000\103\000\095\000\
\000\000\000\000\224\255\065\000\000\000\093\000\000\000\000\000\
\000\000\000\000\006\000\000\000"

let yytablesize = 141
let yytable = "\013\000\
\038\000\056\000\046\000\001\000\123\000\124\000\010\000\052\000\
\058\000\044\000\045\000\063\000\064\000\014\000\054\000\055\000\
\035\000\011\000\022\000\012\000\057\000\058\000\023\000\024\000\
\028\000\029\000\025\000\026\000\027\000\021\000\036\000\011\000\
\074\000\012\000\032\000\052\000\032\000\037\000\028\000\029\000\
\040\000\032\000\032\000\041\000\059\000\042\000\032\000\032\000\
\103\000\104\000\079\000\080\000\081\000\082\000\083\000\050\000\
\084\000\085\000\086\000\087\000\088\000\089\000\090\000\091\000\
\092\000\093\000\094\000\095\000\096\000\097\000\098\000\041\000\
\047\000\042\000\003\000\004\000\005\000\006\000\007\000\041\000\
\016\000\042\000\016\000\065\000\043\000\015\000\016\000\017\000\
\018\000\019\000\072\000\073\000\120\000\121\000\108\000\018\000\
\018\000\017\000\017\000\019\000\019\000\020\000\020\000\051\000\
\069\000\066\000\068\000\067\000\070\000\071\000\075\000\076\000\
\078\000\100\000\102\000\113\000\101\000\105\000\106\000\109\000\
\112\000\115\000\107\000\111\000\116\000\114\000\117\000\129\000\
\119\000\039\000\130\000\049\000\077\000\132\000\029\000\062\000\
\131\000\134\000\133\000\000\000\065\000"

let yycheck = "\010\000\
\027\000\016\001\035\000\001\000\032\001\033\001\049\001\040\000\
\036\001\045\001\046\001\044\000\045\000\051\001\041\000\042\000\
\049\001\059\001\039\001\061\001\035\001\036\001\043\001\044\001\
\059\001\060\001\047\001\048\001\049\001\051\001\054\001\059\001\
\065\000\061\001\038\001\068\000\040\001\054\001\059\001\060\001\
\049\001\045\001\046\001\038\001\059\001\040\001\050\001\051\001\
\075\000\076\000\011\001\012\001\013\001\014\001\015\001\050\001\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\024\001\
\025\001\026\001\027\001\028\001\029\001\030\001\031\001\038\001\
\060\001\040\001\001\001\002\001\003\001\004\001\005\001\038\001\
\038\001\040\001\040\001\045\001\051\001\006\001\007\001\008\001\
\009\001\010\001\050\001\051\001\057\001\058\001\105\000\050\001\
\051\001\050\001\051\001\050\001\051\001\050\001\051\001\050\001\
\050\001\055\001\051\001\055\001\049\001\049\001\053\001\053\001\
\056\001\052\001\050\001\037\001\054\001\051\001\051\001\054\001\
\050\001\050\001\059\001\055\001\049\001\051\001\054\001\050\001\
\052\001\027\000\050\001\037\000\068\000\051\001\050\001\043\000\
\055\001\132\000\055\001\255\255\055\001"

let yynames_const = "\
  THF\000\
  TFF\000\
  FOF\000\
  CNF\000\
  TPI\000\
  AXIOM\000\
  HYPOTHESIS\000\
  CONJECTURE\000\
  NEG_CONJECTURE\000\
  PLAIN\000\
  ER\000\
  PM\000\
  SPM\000\
  EF\000\
  APPLY_DEF\000\
  INTRODUCED_DEF\000\
  RW\000\
  SR\000\
  CSR\000\
  AR\000\
  CN\000\
  CONDENSE\000\
  ASSUME_NEGATION\000\
  FOF_NNF\000\
  SHIFT_QUANTORS\000\
  VARIABLE_RENAME\000\
  SKOLEMIZE\000\
  DISTRIBUTE\000\
  SPLIT_CONJUNCT\000\
  SPLIT_EQUIV\000\
  FOF_SIMPLIFICATION\000\
  TH_EQ\000\
  TH_EQ_S\000\
  FILE\000\
  INFERENCE\000\
  STATUS\000\
  OR\000\
  NOT\000\
  AND\000\
  IMP\000\
  BIMP\000\
  FORALL\000\
  EXISTS\000\
  EQ\000\
  NEQ\000\
  FALSE\000\
  TRUE\000\
  LPAREN\000\
  RPAREN\000\
  COMMA\000\
  DOT\000\
  COLON\000\
  LBRACKET\000\
  RBRACKET\000\
  FILEPATH\000\
  THM\000\
  CTH\000\
  "

let yynames_block = "\
  ATOM\000\
  WORD\000\
  VAR\000\
  INTEGER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 10 : 'theory) in
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'name) in
    let _5 = (Parsing.peek_val __caml_parser_env 6 : 'role) in
    let _7 = (Parsing.peek_val __caml_parser_env 4 : 'formula) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'annotation) in
    Obj.repr(
# 62 "tstpparser.mly"
                                                                          (
  match _1 with
    | FOF | CNF ->
      let name = _3 in
      let formula = _7 in
      let (inference, parents) = match _9 with
        | (AXIOM, []) -> if (_5 = "axiom" || _5 = "neg_conjecture" || _5 = "hypothesis") then (AXIOM, [])
          else if _5 = "conjecture" then (CONJECTURE, [])
          else begin
            print_endline ("Unexpected role: \'" ^ _5 ^ "\' for leaf.");
            exit 3
          end
        | (INTRODUCED_DEF, []) -> (AXIOM, [])
        | _ -> _9
      in
      let free_vars = List.filter (fun used -> not (List.mem used !quantified_vars) ) !used_vars in
      let closed_formula = List.fold_left (fun acc fv -> "(all (" ^ fv ^ "\\ " ^ acc ^ "))") formula free_vars in
      used_vars := [];
      quantified_vars := [];
      DAG.insert proof_dag name closed_formula inference parents;
      proof_dag
    | _ -> print_endline ("Unsupported theory: " ^ (theoryToString _1)); exit 4
)
# 403 "tstpparser.ml"
               : Proof.DAG.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 14 : 'theory) in
    let _3 = (Parsing.peek_val __caml_parser_env 12 : 'name) in
    let _5 = (Parsing.peek_val __caml_parser_env 10 : 'role) in
    let _7 = (Parsing.peek_val __caml_parser_env 8 : 'formula) in
    let _9 = (Parsing.peek_val __caml_parser_env 6 : 'annotation) in
    let _12 = (Parsing.peek_val __caml_parser_env 3 : string) in
    Obj.repr(
# 86 "tstpparser.mly"
                                                                                                       (
  match _1 with
    | FOF | CNF ->
      let name = _3 in
      let formula = _7 in
      let (inference, parents) = match _9 with
        | (AXIOM, []) -> if (_5 = "axiom" || _5 = "neg_conjecture" || _5 = "hypothesis") then (AXIOM, [])
          else if _5 = "conjecture" then (CONJECTURE, [])
          else begin
            print_endline ("Unexpected role: \'" ^ _5 ^ "\' for leaf.");
            exit 3
          end
        | (INTRODUCED_DEF, []) -> (AXIOM, [])
        | _ -> _9
      in
      let free_vars = List.filter (fun used -> not (List.mem used !quantified_vars) ) !used_vars in
      let closed_formula = List.fold_left (fun acc fv -> "(all (" ^ fv ^ "\\ " ^ acc ^ "))") formula free_vars in
      used_vars := [];
      quantified_vars := [];
      DAG.insert proof_dag name closed_formula inference parents;
      proof_dag
    | _ -> print_endline ("Unsupported theory: " ^ (theoryToString _1)); exit 4
)
# 437 "tstpparser.ml"
               : Proof.DAG.t))
; (fun __caml_parser_env ->
    Obj.repr(
# 111 "tstpparser.mly"
      ( FOF )
# 443 "tstpparser.ml"
               : 'theory))
; (fun __caml_parser_env ->
    Obj.repr(
# 112 "tstpparser.mly"
      ( CNF )
# 449 "tstpparser.ml"
               : 'theory))
; (fun __caml_parser_env ->
    Obj.repr(
# 113 "tstpparser.mly"
      ( THF )
# 455 "tstpparser.ml"
               : 'theory))
; (fun __caml_parser_env ->
    Obj.repr(
# 114 "tstpparser.mly"
      ( TFF )
# 461 "tstpparser.ml"
               : 'theory))
; (fun __caml_parser_env ->
    Obj.repr(
# 115 "tstpparser.mly"
      ( TPI )
# 467 "tstpparser.ml"
               : 'theory))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 118 "tstpparser.mly"
          ( _1 )
# 474 "tstpparser.ml"
               : 'name))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 119 "tstpparser.mly"
          ( string_of_int _1 )
# 481 "tstpparser.ml"
               : 'name))
; (fun __caml_parser_env ->
    Obj.repr(
# 122 "tstpparser.mly"
                 ( "axiom" )
# 487 "tstpparser.ml"
               : 'role))
; (fun __caml_parser_env ->
    Obj.repr(
# 123 "tstpparser.mly"
                 ( "hypothesis" )
# 493 "tstpparser.ml"
               : 'role))
; (fun __caml_parser_env ->
    Obj.repr(
# 124 "tstpparser.mly"
                 ( "conjecture" )
# 499 "tstpparser.ml"
               : 'role))
; (fun __caml_parser_env ->
    Obj.repr(
# 125 "tstpparser.mly"
                 ( "neg_conjecture" )
# 505 "tstpparser.ml"
               : 'role))
; (fun __caml_parser_env ->
    Obj.repr(
# 126 "tstpparser.mly"
                 ( "plain" )
# 511 "tstpparser.ml"
               : 'role))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'formula) in
    Obj.repr(
# 130 "tstpparser.mly"
                        ( _2 )
# 518 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 131 "tstpparser.mly"
                        ( _1 )
# 525 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formula) in
    Obj.repr(
# 132 "tstpparser.mly"
                        ( _1 ^ " &+& " ^ _3 )
# 533 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formula) in
    Obj.repr(
# 133 "tstpparser.mly"
                        ( _1 ^ " !-! " ^ _3 )
# 541 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'qvar) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'formula) in
    Obj.repr(
# 138 "tstpparser.mly"
                                                ( "(all (" ^ _3 ^ "\\ " ^ _6 ^ ")) " )
# 549 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'qvar) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'formula) in
    Obj.repr(
# 139 "tstpparser.mly"
                                                ( "(some (" ^ _3 ^ "\\ " ^ _6 ^ ")) " )
# 557 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 140 "tstpparser.mly"
                        ( "f-" )
# 563 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 141 "tstpparser.mly"
                        ( "t+" )
# 569 "tstpparser.ml"
               : 'formula))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'atom) in
    Obj.repr(
# 144 "tstpparser.mly"
                     ( _2 )
# 576 "tstpparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'pos_atom) in
    Obj.repr(
# 145 "tstpparser.mly"
                     ( "(n " ^ _1 ^ ")" )
# 583 "tstpparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'neg_atom) in
    Obj.repr(
# 146 "tstpparser.mly"
                     ( "(p " ^ _1 ^ ")" )
# 590 "tstpparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 149 "tstpparser.mly"
                                 ( "(" ^ _1 ^ " == " ^ _3 ^ ")" )
# 598 "tstpparser.ml"
               : 'neg_atom))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'term) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'term) in
    Obj.repr(
# 150 "tstpparser.mly"
                                 ( "(" ^ _3 ^ " == " ^ _5 ^ ")" )
# 606 "tstpparser.ml"
               : 'neg_atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 155 "tstpparser.mly"
                          ( "(" ^ _1 ^ " == " ^ _3 ^ ")" )
# 614 "tstpparser.ml"
               : 'pos_atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 160 "tstpparser.mly"
                  ( _1 )
# 621 "tstpparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 161 "tstpparser.mly"
                  ( _1 ^ " " ^ _3 )
# 629 "tstpparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 164 "tstpparser.mly"
              ( add_var _1 used_vars; _1 )
# 636 "tstpparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 165 "tstpparser.mly"
              ( DAG.set_function proof_dag _1 0; _1 )
# 643 "tstpparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 166 "tstpparser.mly"
                          (
  DAG.set_function proof_dag _1 (getNumArgs _3);
  "(" ^ _1 ^ " " ^ _3 ^ ")" )
# 653 "tstpparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 171 "tstpparser.mly"
       ( add_var _1 quantified_vars; _1 )
# 660 "tstpparser.ml"
               : 'qvar))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'file_info) in
    Obj.repr(
# 174 "tstpparser.mly"
                 ( (AXIOM, []) )
# 667 "tstpparser.ml"
               : 'annotation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'inference_info) in
    Obj.repr(
# 175 "tstpparser.mly"
                 ( _1 )
# 674 "tstpparser.ml"
               : 'annotation))
; (fun __caml_parser_env ->
    Obj.repr(
# 176 "tstpparser.mly"
                 ( (INTRODUCED_DEF, []) )
# 680 "tstpparser.ml"
               : 'annotation))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 177 "tstpparser.mly"
                 ( (DONE, [_1]) )
# 687 "tstpparser.ml"
               : 'annotation))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'name) in
    Obj.repr(
# 180 "tstpparser.mly"
                                         ( "" )
# 694 "tstpparser.ml"
               : 'file_info))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'inf_name) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'status) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'antecedents) in
    Obj.repr(
# 183 "tstpparser.mly"
                                                                  (
  (_3, _7)
)
# 705 "tstpparser.ml"
               : 'inference_info))
; (fun __caml_parser_env ->
    Obj.repr(
# 188 "tstpparser.mly"
                     ( ER )
# 711 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 189 "tstpparser.mly"
                     ( PM )
# 717 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 190 "tstpparser.mly"
                     ( SPM )
# 723 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 191 "tstpparser.mly"
                     ( EF )
# 729 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 192 "tstpparser.mly"
                     ( APPLY_DEF )
# 735 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 193 "tstpparser.mly"
                     ( RW )
# 741 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 194 "tstpparser.mly"
                     ( SR )
# 747 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 195 "tstpparser.mly"
                     ( CSR )
# 753 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 196 "tstpparser.mly"
                     ( AR )
# 759 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 197 "tstpparser.mly"
                     ( CN )
# 765 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 198 "tstpparser.mly"
                     ( CONDENSE )
# 771 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 199 "tstpparser.mly"
                     ( ASSUME_NEGATION )
# 777 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 200 "tstpparser.mly"
                     ( FOF_NNF )
# 783 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 201 "tstpparser.mly"
                     ( SHIFT_QUANTORS )
# 789 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 202 "tstpparser.mly"
                     ( VARIABLE_RENAME )
# 795 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 203 "tstpparser.mly"
                     ( SKOLEMIZE )
# 801 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 204 "tstpparser.mly"
                     ( DISTRIBUTE )
# 807 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 205 "tstpparser.mly"
                     ( SPLIT_CONJUNCT )
# 813 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 206 "tstpparser.mly"
                     ( SPLIT_EQUIV )
# 819 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    Obj.repr(
# 207 "tstpparser.mly"
                     ( FOF_SIMPLIFICATION )
# 825 "tstpparser.ml"
               : 'inf_name))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'status_type) in
    Obj.repr(
# 211 "tstpparser.mly"
                                                     ( "" )
# 832 "tstpparser.ml"
               : 'status))
; (fun __caml_parser_env ->
    Obj.repr(
# 214 "tstpparser.mly"
      ( "thm" )
# 838 "tstpparser.ml"
               : 'status_type))
; (fun __caml_parser_env ->
    Obj.repr(
# 215 "tstpparser.mly"
      ( "cth" )
# 844 "tstpparser.ml"
               : 'status_type))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'antlist) in
    Obj.repr(
# 219 "tstpparser.mly"
                            ( _2 )
# 851 "tstpparser.ml"
               : 'antecedents))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ant) in
    Obj.repr(
# 222 "tstpparser.mly"
                    ( _1 )
# 858 "tstpparser.ml"
               : 'antlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'ant) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'antlist) in
    Obj.repr(
# 223 "tstpparser.mly"
                    ( _1 @ _3 )
# 866 "tstpparser.ml"
               : 'antlist))
; (fun __caml_parser_env ->
    Obj.repr(
# 226 "tstpparser.mly"
                 ( [] )
# 872 "tstpparser.ml"
               : 'ant))
; (fun __caml_parser_env ->
    Obj.repr(
# 227 "tstpparser.mly"
                 ( [] )
# 878 "tstpparser.ml"
               : 'ant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'name) in
    Obj.repr(
# 228 "tstpparser.mly"
                 ( [_1] )
# 885 "tstpparser.ml"
               : 'ant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'inference_info) in
    Obj.repr(
# 229 "tstpparser.mly"
                 ( print_endline ("Nested inferences are not supported"); exit 2 (*match $1 with (_, ant) -> ant*) )
# 892 "tstpparser.ml"
               : 'ant))
(* Entry proof *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let proof (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Proof.DAG.t)
