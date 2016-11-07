module ex-nseq1.

accumulate nested-sequents.
accumulate lkf-kernel.
accumulate modal-encoding.

% Here I list each subformula of the example formula, with the corresponding node_index and multifocusing_index

% ((dia((++p1) && (--q1))) !! ((dia(--p1)) !! (box (++q1)))) --- root , 1

% (dia((++p1) && (--q1))) --- lind root , 4
% ((++p1) && (--q1)) --- diaind (lind root) (rind (rind root)) , 5
% (++p1) --- lind (diaind (lind root) (rind (rind root))) , 7
% (--q1) --- rind (diaind (lind root) (rind (rind root))) , 8

% ((dia(--p1)) !! (box (++q1))) --- rind root , 2
% (dia(--p1)) --- lind (rind root) , 4
% (box (++q1)) --- rind (rind root) , 3
% (--p1) --- diaind (lind (rind root)) (rind (rind root)) , 6
% (++q1) --- lind (rind (rind root)) , 9


modalProblem "Problem: Axiom K for nested-sequents"
((dia((++ p1) && (-- q1))) !! ((dia(-- p1)) !! (box (++ q1))))

% the first argument of lmf-star-cert is the initial state (H, future, map_index_label) defined as:
% H = [root]
% future = none
% map_index_label = [pr root root]
% mfi 0
% []
% []

(nested-sequent-cert
	(nested-sequent-state [root] none [pr root root] 0 [] [])
  (lmf-tree (nested-sequent-node (ns root zb)  none) [
		(lmf-tree (nested-sequent-node (ns (rind root) zb) none) [
			(lmf-tree (nested-sequent-node (ns (rind (rind root)) zb) none) [
				(lmf-tree (nested-sequent-node (ns (lind (rind root)) zb) (ns (rind (rind root)) zb)) [
					(lmf-tree (nested-sequent-node (ns (lind root) zb) (ns (rind (rind root)) zb)) [
						(lmf-tree (nested-sequent-node (ns (lind root) (chld 1 zb)) none) [
							(lmf-tree (nested-sequent-node (ns (rind (lind root)) (chld 1 zb)) none) [
								(lmf-tree (nested-sequent-node (ns (rind (rind root)) (chld 1 zb)) (ns (rind (lind root)) (chld 1 zb))) [])]) ,
							(lmf-tree (nested-sequent-node (ns (lind (rind root)) (chld 1 zb)) none ) [
								(lmf-tree (nested-sequent-node (ns (lind (lind root)) (chld 1 zb)) (ns (lind (rind root)) (chld 1 zb))) [])])])])])])])])).
