sig tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

% a certificate for modal tableaux will contain
% 1) a decision tree telling on which formula to decide next
% 2) a map between an (abstract) index identifying a diamond and the index of a box
% 3) a map between an (abstract) index identifying an atom and an index of a complementary one

% The abstract indices will allow to choose from a precise deterministic choice of the actual instance of diamond or init applications
% to a less precise identification of the formula only

% types for the decisition tree component
kind dectree type.
% types for the diamond-box map
kind diabox-map, diabox-entry type.
% types for the initial rule map
kind init-map, init-entry type.
% types for the map containing axiom indices
kind axiom-map, axiom-entry type.


% types for the certification state which is carried by the certificate
kind state, eigen-entry, decide-bound-entry type.

% the decide tree
type dectree index -> list dectree -> dectree.

% a state containing the last formula we have encountered. Used to connect the index of the stored formula to the index of its parent
% the second state component is the eigenvariable which is mapped to a box position
% the last component is a map between an index to the maximal nested numbers we can decide on it
type state list index ->  list eigen-entry -> list decide-bound-entry -> state.
type eigen-entry index -> atm -> eigen-entry.

% numbers for resitrcting decide depth
kind num type.
type znum num.
type snum num -> num.

% warning, what happens if we dont have a decide tree and all indices are inferred? we can get an index lind X where X can be anything!
% we might be able to solve it by choosing eind for the root node since there is only one choice then!
type decide-bound-entry index -> num -> decide-bound-entry.

% a generic certificate for modal tableaux proofs
type modtab-cert dectree -> diabox-map -> init-map -> axiom-map -> state -> cert.

% a map between dia indices and eigenvariables
type diabox-entry index -> index -> diabox-entry.
type diabox-map list diabox-entry -> diabox-map.

% a map between init indices and a complementary index
type init-entry index -> index -> init-entry.
type init-map list init-entry -> init-map.

% a map between diamonds relating to axioms and the index of the axiom
type axiom-entry index -> list index -> axiom-entry.
type axiom-map list axiom-entry -> axiom-map.

% the formula-index type
% an index is the (1) left or (2) right child of an index (this is used for classical connectives and diamond),
% (3) the box child of an index (in this case, we also add info about the corresponding diamond)
type eind index. % corresponds to the root
type lind index -> index.
type rind index -> index.
type bind index -> index -> index.

% for the accessibility relation, we use the same 'rel' in all problems
type rel A -> A -> atm.

% fixed index for relations, should be improved!
type relind index.

% sum types for dia and init indices
% the user will choose which constructor to use in order to create these indices
% and the fpc will pattern match on the constructor in order to know which semantics to use
% right now we support only the simpler constructor of using an actual formula index

type reduce_or_set_decide_bound (list decide-bound-entry) -> index -> num -> (list decide-bound-entry) -> o.

% the default world
type zero A.

type default-ind index.
