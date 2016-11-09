module ordinary-sequents.

accumulate lmf-star.
accumulate debug.
accumulate lists.

% helpers

%obtain_os_node_vals
%(ordinary-sequent-cert (ordinary-sequent-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert S1 (lmf-tree
  %(lmf-star-node NH NF
    %(lmf-multifoc-node M
      %(lmf-singlefoc-node I IO))) C))))
%H F Map NH NF M I IO.

% generate a tree containing lmf-star nodes such that the top one is I with OI none (the box)
% then a sequence of diamonds according to the indices in OI finishing with C as the rest of the tree
% we generate the tree backward so the list of OI must be reversed first
% H is changed only on the last diamond, where it gets the index of the box
% F is none for the box and the index of the box for the diamonds
% mv: The MFI does not work (it is not set to 1 in the case of diamonds) but for the moment we do not use them
generate_diamonds I [D|[X|Xs]] C
  [(lmf-tree
    (lmf-star-node H I
      (lmf-multifoc-node (MFI+1)
        (lmf-singlefoc-node D I))) T)]
  H F MFI :-
  generate_diamonds I [X|Xs] C T H F MFI.

% the last one needs to change the H
generate_diamonds I [D] C
    [(lmf-tree
      (lmf-star-node [I] I
        (lmf-multifoc-node (MFI+1)
          (lmf-singlefoc-node D I))) C)]
  H F MFI.

ordinary-sequent-to-lmf-star
  (ordinary-sequent-cert
    (ordinary-sequent-state H F Map MFI IL Eig) (lmf-tree (ordinary-sequent-node I OI) C))
    OI
  (lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree
    (lmf-star-node H F (lmf-multifoc-node 0 (lmf-singlefoc-node I none))) C)))).

ordinary-sequent-to-lmf-star-with-op-index
  (ordinary-sequent-cert
    (ordinary-sequent-state H F Map MFI IL Eig) (lmf-tree (ordinary-sequent-node I [OI]) C))
  (lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree
    (lmf-star-node H F (lmf-multifoc-node 0 (lmf-singlefoc-node I OI))) C)))).

lmf-star-to-ordinary-sequent
  (lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree
    (ordinary-sequent-node I OI) C))))
    _
  (ordinary-sequent-cert
    (ordinary-sequent-state H F Map MFI IL Eig) (lmf-tree
    (ordinary-sequent-node I OI) C)).
 
lmf-star-to-ordinary-sequent
  (lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree
    (lmf-star-node _ _ (lmf-multifoc-node MFI (lmf-singlefoc-node I _))) C))))
    OI
  (ordinary-sequent-cert
    (ordinary-sequent-state H F Map MFI IL Eig) (lmf-tree (ordinary-sequent-node I OI) C)).
 
 
% mv: PREVIOUS VERSION    
%lmf-star-to-ordinary-sequent
  %(lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree
    %(lmf-star-node _ _ (lmf-multifoc-node MFI (lmf-singlefoc-node I _))) C))))
  %(ordinary-sequent-cert
    %(ordinary-sequent-state H F Map MFI IL Eig) (lmf-tree (ordinary-sequent-node I []) C)).

% all rules except decide and init just use values from the state and the index in the node
% in order to create an lmf-star certificate
% init uses the optional index as well

% changing into lmf-star cert and node while using none for the optional index in the node
% using values from the state for the nodes, i.e. nodes in osequents do not have info about
% changing states
%ordinary-sequent-to-lmf-star Cert Cert-s.

% as above but we do use the optional index (and ensure it has only one element)
%ordinary-sequent-to-lmf-star-with-op-index Cert Cert-s.

% translating back, using the same states but changing the cert and node
% do we need to keep track of the OI? since we ignore it in the other translation?
%lmf-star-to-ordinary-sequent Cert-s' Cert-r.

% decide might have nodes which are already lmf-star nodes
% for them, we change certificate to lmf-star
% when we decide on anything else and the certificate is lmf-star
% (i.e. the node is osequent but the certificate is lmf-star)
% we need to convert the cert again to osequent.
% note that since the node will be osequent, none of the experts in lmf-star
% will unify against it

% here we are just after the last generated diamond and need to change back the cert
decide_ke
  (lmf-star-cert (lmf-star-state H F Map) (lmf-multifoc-cert (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree (ordinary-sequent-node I OI) C))))
  L
  Cert' :-
  decide_ke
    (ordinary-sequent-cert
      (ordinary-sequent-state H F Map 0 IL Eig) (lmf-tree (ordinary-sequent-node I OI) C))
      L
      Cert'.

% decide is the same as the others and just operate on lmf-star level
decide_ke Cert L Cert' :-
  ordinary-sequent-to-lmf-star Cert IO Cert-s,
  decide_ke Cert-s L Cert-s',
  lmf-star-to-ordinary-sequent Cert-s' IO Cert'.

store_kc Cert L B Cert' :-
(ordinary-sequent-to-lmf-star Cert OI Cert-s),
(store_kc Cert-s L B Cert-s'),
(lmf-star-to-ordinary-sequent Cert-s' OI Cert').


release_ke Cert Cert.

% we use here the optional index, which must be a single index
initial_ke Cert O :-
  ordinary-sequent-to-lmf-star-with-op-index Cert Cert-s,
  initial_ke Cert-s O.

orNeg_kc Cert Form Cert-r :-
 (ordinary-sequent-to-lmf-star Cert IO Cert-s),
 (orNeg_kc Cert-s Form Cert-s'),
 (lmf-star-to-ordinary-sequent Cert-s' IO Cert-r).

andNeg_kc Cert Form Cert1 Cert2 :-
  (ordinary-sequent-to-lmf-star Cert IO Cert-s),
  (andNeg_kc Cert-s Form Cert1' Cert2'),
  (lmf-star-to-ordinary-sequent Cert1' IO Cert1),
  (lmf-star-to-ordinary-sequent Cert2' IO Cert2).

andPos_k Cert Form Str Cert1 Cert2 :-
    ordinary-sequent-to-lmf-star Cert IO Cert-s,
  andPos_k Cert-s Form Str Cert1' Cert2',
  lmf-star-to-ordinary-sequent Cert1' IO Cert1,
  lmf-star-to-ordinary-sequent Cert2' IO Cert2.

% we ignore here (in the node) the optional index, which contains the list of diamond indices
% here we must use this optional index in order to create the diamond nodes
% we will also leave it with a lmf-star cert to force it to apply diamonds until there are no more
% dia nodes, at this point, the decide above will change it back to osequents
all_kc
  (ordinary-sequent-cert
    (ordinary-sequent-state H F Map _ IL Eig)
      (lmf-tree (ordinary-sequent-node I OI) C))
   Cert-r :-
  % we first generate the tree, putting the box node at the top
  % below it all the diamonds and finish with C
  % we dont have tail recursion and must reverse the diamonds indices
  % TOFIX: MFI is right now 0 for everything and 1 for all diamonds
  % if the list OI =  [1,2,3], then immediately after the box we do 1, then 2 and then 3
  (generate_diamonds I OI C T H F 0),
  (all_kc
    (lmf-star-cert (lmf-star-state H F Map)
      (lmf-multifoc-cert
        (lmf-singlefoc-cert (lmf-singlefoc-state IL Eig) (lmf-tree (lmf-star-node H F (lmf-multifoc-node 0 (lmf-singlefoc-node I none))) T))))
    Cert-r).
    

    % there are no diamonds in the calculus so cannot happen
%some_ke Cert X Cert'-r :-


