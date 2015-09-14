module eprover.

%accumulate binary_res_fol_nosub.
accumulate paramodulation.

% gets a sequent |- A !-! B, C, D !-! E, etc.

%binary rules, use the right indices and the right resolution certificate
% eprover doesnt distinct between the from and into clauses so we try both directions

res_step (pm (id I) (id J) K) (pid I) (pid J) K.
res_step (pm (id I) (id J) K) (pid J) (pid I) K.

res_step (rw (id I) (id J) K) (pid I) (pid J) K.
res_step (rw (id I) (id J) K) (pid J) (pid I) K.
