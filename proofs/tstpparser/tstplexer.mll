
{
open Tstpparser
open Lexing

exception EoF

let incrline lexbuf =
    lexbuf.lex_curr_p <- {
    lexbuf.lex_curr_p with
    pos_bol = lexbuf.lex_curr_p.pos_cnum;
    pos_lnum = 1 + lexbuf.lex_curr_p.pos_lnum }
}

let word = ['a'-'z']+['a'-'z' 'A'-'Z' '0'-'9' '_']*
let integer = ['0'-'9']+
let filepath = ''' [^''']* '''
let comment_line = ['%'] [^'\n']* (* comments start with % *)

rule tstpproof = parse

[' ' '\t' '\r']		{ tstpproof lexbuf }
| comment_line		{ incrline lexbuf; tstpproof lexbuf }
| '\n'			{ incrline lexbuf; tstpproof lexbuf }
| "thf"  		{ THF }
| "tff"  		{ TFF }
| "fof"  		{ FOF }
| "cnf"  		{ CNF }
| "tpi"  		{ TPI }
| "file"        	{ FILE }
| "inference"   	{ INFERENCE }
| "axiom"               { AXIOM }
| "conjecture"         	{ CONJECTURE }
| "negated_conjecture" 	{ NEG_CONJECTURE }
| "plain"               { PLAIN }
| "|"                   { OR }
| "~"                   { NOT }
| "&"                   { AND }
| "=>" 			{ IMP }
| "$false"		{ FALSE }
| "$true"		{ TRUE }
| "("    		{ LPAREN }
| ")"    		{ RPAREN }
| "["			{ LBRACKET }
| "]"			{ RBRACKET }
| "," 			{ COMMA }
| "."           	{ DOT }
| "status"     		{ STATUS }
| "thm"			{ THM }
| "cth"			{ CTH }
| word as w             { WORD(w) }
| integer as i          { INTEGER(int_of_string i) }
| filepath		{ FILEPATH }
| eof                   { raise EoF }
| _ as c		{ Printf.printf "Unrecognized character: %c\n" c; raise (Failure "")}
