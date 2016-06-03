open Batteries
open Dectree

let filename = Sys.argv.(1) (* input *)
let name = Sys.argv.(2) (* name of module and problem *)
let form = Sys.argv.(3) (* the positive modal formula in nnf *)

let rec ind2string = function
  | Eind -> "eind"
  | Lind ind -> "(lind " ^ ind2string ind ^ ")"
  | Rind ind -> "(rind " ^ ind2string ind ^ ")"
  | Bind (ind1, ind2) -> "(bind (" ^ ind2string ind1 ^ ") (" ^ ind2string ind2 ^ "))"

let rec print_tree out = function
  | Dectree (ind1, ind2, ls) ->
      let () = output_string out "(dectree " in
      let ind2txt = match ind2 with
      | None -> "none"
      | Some (ind2b) -> ind2string ind2b in
      let () = output_string out ((ind2string ind1) ^ " " ^ ind2txt ^ " [") in
      let b = ref false in
      let () = List.iter (fun x -> if (!b) then (output_string out ", ") else (b := true) ;print_tree out x) ls in
      output_string out "])"

let main () =
  let input = open_in filename in
  let filebuf = Lexing.from_input input in
  try
    match (Parser.main Lexer.token filebuf) with
    | None -> Printf.eprintf "No tree was generated!"
    | Some (dectree) ->
      let output = open_out (name ^ ".sig") in
      let () = output_string output ("sig " ^ name ^ ".\naccum_sig lkf-syntax.\naccum_sig lkf-kernel.\naccum_sig base.\naccum_sig certificatesLKF.\naccum_sig fittings-tableaux.\naccum_sig lists.\naccum_sig modal-syntax.\n") in
      let () = output_string output "type p1 A -> atm.\ntype q1 A -> atm." in
      let () = flush output in
      let () = close_out output in
      let output = open_out (name ^ ".mod") in
      let () = output_string output ("module " ^ name ^ ".\naccumulate fittings-tableaux.\naccumulate lkf-kernel.\n"
      ^"modalProblem \"" ^ name ^ "\"\n(" ^ form ^ ")\n(fitcert []\n(") in
      let _ = print_tree output dectree in
      let () = output_string output ") [] )." in
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
