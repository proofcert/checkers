open Batteries

open Dectree

(* the name of the file which contains the expressions *)
let filename = Sys.argv.(1)

let print_dot _ = Printf.eprintf "todo"

let main () =
  let input = open_in filename in
  let filebuf = Lexing.from_input input in
  try
    print_dot (Parser.main Lexer.token filebuf)
  with
  | Lexer.Error msg ->
      Printf.eprintf "%s%!" msg
  | Parser.Error ->
      Printf.eprintf "At offset %d: syntax error.\n%!" (Lexing.lexeme_start filebuf)
  ;
  IO.close_in input

let _ = main ()
