module labrunner.

accumulate lists.
accumulate debug.

labcheck Formula Labcert :-
  if (entry_point (labcert Labcert) Formula)
      (print "Success\n==============================================\n")
		  (print "Fail\n", halt), fail.
