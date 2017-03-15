(* elpi: embedded lambda prolog interpreter                                  *)
(* copyright: 2014 - Enrico Tassi <enrico.tassi@inria.fr>                    *)
(* license: GNU Lesser General Public License Version 2.1                    *)
(* ------------------------------------------------------------------------- *)

exception TREC_CALL of Obj.t * Obj.t (* ('a -> 'b) * 'a *)

val enter : string ->  (Format.formatter -> unit) -> unit
val print : string -> (Format.formatter -> 'a -> unit) -> 'a -> unit
val exit : string -> bool -> ?e:exn -> float -> unit

exception Unknown
val pr_exn : (exn -> string) -> unit

val debug : bool ref
val dverbose : bool ref

val get_cur_step : string -> int

val parse_argv : string array -> string array
val usage: string
