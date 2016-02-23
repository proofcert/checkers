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

val proof :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Proof.DAG.t
