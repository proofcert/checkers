type index =
  | Eind
  | Lind of index
  | Rind of index
  | Bind of index * index

type dec_tree = Dectree of index * index option * dec_tree list


