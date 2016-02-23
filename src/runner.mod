module runner.

accumulate tab1.

accumulate lists.
accumulate debug.

run :-
  problem Name F Cert (map Map),
  print "Running on problem ", print Name, print ":\n",
  resolve Map F Cert.

resolve [] F Cert :-
  if (entry_point Cert F)
      (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.
resolve [(pr I C) | R] F Cert :-
  mapsto I C => resolve R F Cert.
