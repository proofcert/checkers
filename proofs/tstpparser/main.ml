open Printf

let _ =
  let file_name = Sys.argv.(1) in
  let mod_name = Sys.argv.(2) in
  let file = open_in file_name in
  let lexbuf = Lexing.from_channel file in 
  let proof_dag = ref (Proof.DAG.create ()) in
  try
    while true do
      proof_dag := Tstpparser.proof Tstplexer.tstpproof lexbuf
      (*print_string result; print_newline (); flush stdout*)
    done
  with Tstplexer.EoF ->
    let mod_file = open_out (mod_name ^ ".mod") in
    let sig_file = open_out (mod_name ^ ".sig") in
    fprintf mod_file "%s" (Proof.printCert !proof_dag mod_name);
    fprintf sig_file "sig %s." mod_name;
    close_out mod_file;
    close_out sig_file;
    exit 0;
;;
