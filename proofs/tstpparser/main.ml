
let _ =
  let file_name = Sys.argv.(1) in
  let file = open_in file_name in
  let lexbuf = Lexing.from_channel file in 
  try
    while true do
      let result = Tstpparser.proof Tstplexer.tstpproof lexbuf in
      print_string result; print_newline (); flush stdout
    done
  with Tstplexer.EoF -> exit 0
;;
