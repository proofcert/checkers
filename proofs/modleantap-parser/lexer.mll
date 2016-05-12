{
  open Parser

  exception Error of string
}

rule token = parse
| [' ' '\t' '\n'] (* also ignore newlines, not only whitespace and tabs *)
  { token lexbuf }
(* add the semicolon as a new token *)
| "dectree"
  { DCT }
| "eind"
  { EI }
| "lind"
  { LI }
| "rind"
  { RI }
| "bind"
  { BI }
| '('
  { LP }
| ')'
  { RP }
| '['
  { LB }
| ']'
  { RB }
| ','
  { CM }
| "none"
  { NN }
| eof
    { EOF }
| _
    { raise (Error (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }
