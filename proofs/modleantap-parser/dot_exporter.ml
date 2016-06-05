open Batteries
open Dectree

let filename = Sys.argv.(1) (* input *)
let filename2 = Sys.argv.(2) (* output *)

let seed_index = ref 0

let incr_seed() =
  seed_index := !seed_index + 1;
  !seed_index

let rec ind2string = function
  | Eind -> "e"
  | Lind ind -> "l(" ^ ind2string ind ^ ")"
  | Rind ind -> "r(" ^ ind2string ind ^ ")"
  | Bind (ind1, ind2) -> "b(" ^ ind2string ind1 ^ "," ^ ind2string ind2 ^ ")"

let rec print_tree out = function
  | Dectree (ind1, ind2, ls) ->
      let ind2txt = match ind2 with
      | None -> "none"
      | Some (ind2b) -> ind2string ind2b in
      let txt = "(" ^ ind2string ind1 ^ ", " ^ ind2txt ^ ")" in
      let seed = "A" ^ string_of_int (incr_seed ()) in
      let mp = List.map (fun x -> print_tree out x) ls in
      let () = List.iter (fun x -> output_string out (seed ^ " -> " ^ x ^ ";\n")) mp in
      let () = output_string out (seed ^ " [label=\"" ^ txt ^ "\"];") in
      seed


let main () =
  let input = open_in filename in
  let filebuf = Lexing.from_input input in
  try
    match (Parser.main Lexer.token filebuf) with
    | None -> Printf.eprintf "No tree was generated!"
    | Some (dectree) ->
      let output = open_out filename2 in
      let () = output_string output "digraph modlean {\n" in
      let _ = print_tree output dectree in
      let () = output_string output "}" in
      let () = flush output in
      close_out output
  with
  | Lexer.Error msg ->
      Printf.eprintf "%s%!" msg
  | Parser.Error ->
      Printf.eprintf "At offset %d: syntax error.\n%!" (Lexing.lexeme_start filebuf)
  ;
  IO.close_in input

let _ = main ()
