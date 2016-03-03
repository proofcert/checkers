module fvtab1.

accumulate freevar-tableaux.
accumulate lkf-kernel.

modalProblem "fvtableaux problem 1"
  ((box (++ f) && dia (-- g)) && (box ((-- f) !! (++ g))))
	(fvtabcert [closure (label [lpos g (fvind [r,l]), lpos 1 (fvind [])]) (fvind [l,r,l]) (fvind [l,l,l]),
              closure (label [lpos g (fvind [r,l]), lpos 1 (fvind [])]) (fvind [l,l,r]) (fvind [l,r,l]),
              closure (label [lpos g (fvind [r,l]), lpos 1 (fvind [])]) (fvind [l,l,r]) (fvind [l,l,l]),
              closure (label [lpos g (fvind [r,l]), lpos 1 (fvind [])]) (fvind [r,l,r]) (fvind [l,r,l])]
             [boxinfo (fvind [l,l]) (fvind [r,l]), boxinfo (fvind [r]) (fvind [r,l])]).



%type closure label -> index -> index -> closure.
%type boxinfo index -> index -> boxinfo.
%type fvtabcert list closure -> list boxinfo -> cert.
%type fvind list pos -> index.
%type l,r pos.
%type lpos A -> index -> lpos.
%type label list lpos -> label.


