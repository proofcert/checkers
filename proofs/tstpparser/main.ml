
let _ =
  let file_name = Sys.argv.(1) in
  let file = open_in file_name in
  let lexbuf = Lexing.from_channel file in 
  let proof_dag = ref (Proof.DAG.create ()) in
  try
    while true do
      proof_dag := Tstpparser.proof Tstplexer.tstpproof lexbuf
      (*print_string result; print_newline (); flush stdout*)
    done
  with Tstplexer.EoF ->
    print_endline (Proof.printCert !proof_dag); flush stdout;
    exit 0;
;;
