(* Coursera Programming Languages, Homework 3, Provided Code *)

(* only_capitals - Returns a list with only that start with a uppercase letter.
 *
 * Return Type:
 * fn : string list -> string list *)
fun only_capitals xs = List.filter (fn s => Char.isUpper (String.sub (s, 0))) xs

(* longest_string1 - Returns the longest string in a list, in case of a tie, return the element closest to the beginning of the list. If the list is empty, return "".
 *
 * Return Type:
 * fn : string list -> string *)
fun longest_string1 xs = foldl (fn (s1, s2) => if String.size s1 > String.size s2
											   then s1
											   else s2) "" xs


(* longest_string2 - Same behavior as longest_string1, except, in case of a tie, return the element closest to the end of the list.
 *
 * Return Type:
 * fn : string list -> string *)
fun longest_string2 xs = foldl (fn (s1, s2) => if String.size s1 >= String.size s2
											   then s1
											   else s2) "" xs


(* longest_string_helper - Apply a function f to a string list and return the resulting string.
 *
 * Return Type:
 * fn : (int * int -> bool) -> string list -> string *)
fun longest_string_helper f xs = foldl (fn (s1, s2) => if f (String.size s1, String.size s2)
													   then s1
													   else s2) "" xs


(* longest_string3, longest_string4 - Same behavior as longest_string1 and longest_string2.
 *
 * Return Types:
 * fn : string list -> string, fn : string list -> string *)
val longest_string3 = longest_string_helper (fn (s1, s2) => s1 > s2)
val longest_string4 = longest_string_helper (fn (s1, s2) => s1 >= s2)


(* longest_capitalized - Return the longest string which starts with a uppercase letter. If no string, return "", in case of a draw, return the closest to the beginning of the list.
 *
 * Return Types:
 * fn : string list -> string *)
fun longest_capitalized xs = (longest_string1 o only_capitals) xs


(* rev_string - Reverse a string.
 *
 * Return Types:
 * fn : string -> string *)
val rev_string = implode o rev o explode


exception NoAnswer

(* first_answer - Return v for the first time the function f returns SOME v for a element of xs list.
 *
 * Return Types:
 * fn : ('a -> 'b option) -> 'a list -> 'b *)
fun first_answer f xs =
	case xs of
		[] => raise NoAnswer
	  | x::xs' => 
		let
			val ans = f x
		in
			case ans of
				SOME v => v
			  | NONE => first_answer f xs'
		end


(* all_answers - Apply f to all elements of xs and return SOME [v0, v1, ..., v_n], where v_i is a element which f returns SOME k. If any elment return NONE, then returns NONE.
 *
 * Return Types:
 * fn : ('a -> 'b list option) -> 'a list -> 'b list option*)
fun all_answers f [] = SOME []
  | all_answers f xs = 
	let
		fun aux (xs_aux, acc) =
			case xs_aux of
				[] => SOME acc
			  | x::xs' => case f x of
							  SOME v => aux (xs', acc@v)
							| NONE => NONE
	in
		aux (xs, [])
	end


datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
		val r = g f1 f2 
    in
		case p of
			Wildcard          => f1 ()
		  | Variable x        => f2 x
		  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
		  | ConstructorP(_,p) => r p
		  | _                 => 0
    end

(* count_wildcards - Return the total Wildcards in a given pattern.
 *
 * Return Types:
 * fn : pattern -> int *)
fun count_wildcards p = g (fn _ => 1) (fn _ => 0) p


(* count_wild_and_variable_lengths - Return the total Wildcards in a given pattern + the sum of the string lengths of all the variables.
 *
 * Return Types:
 * fn : pattern -> int *)
fun count_wild_and_variable_lengths p = g (fn _ => 1) (fn s => String.size s) p


(* count_some_var - Return how many times s appears as a variable in p.
 *
 * Return Types:
 * fn : pattern -> int *)
fun count_some_var (s, p) = g (fn _ => 0) (fn x => if x = s then 1 else 0) p


(* check_pat - Returns if all variables in p are unique.
 *
 * (Uses mutable references for efficiency.)
 *
 * Return Types:
 * fn : pattern -> bool *)
fun check_pat pattern =
	let

		val names = ref []

		(* not_in_list - Checks if a string s is in the ref string list names, if not, add the name to list and returns true, else returns false.
		 *
		 * Return Types:
		 * fn : string -> bool *)
		fun not_in_list x = if not (List.exists (fn s => x = s) (!names))
						   then ((names := x :: !names); true)
						   else false

		fun pat p_aux = 
			case p_aux of
				Variable x => not_in_list x
			  | TupleP (p::ps') => if pat p
								   then pat (TupleP ps')
								   else false
			  | ConstructorP (_, p) => pat p
			  | _ => true
	in
		pat pattern
	end



(* match - Retuns SOME list of bidings (string * valu), or NONE if there's no valid bindings.
 *
 * Return Types:
 * fn : (valu * pattern) -> (string * valu) list option *)
fun match (_, Wildcard) = SOME []
  | match (v, Variable s) = SOME [(s, v)]
  | match (Unit, UnitP) = SOME []
  | match (Const c2, ConstP c1) = if c2 = c1 then SOME [] else NONE
  | match (Tuple vs, TupleP ps) = 
	let
		val zip = (ListPair.zipEq (vs, ps) handle UnequalLengths => [])
	in
		case zip of
			[] => NONE
		  | _ => all_answers match zip 
	end					  
  | match (Constructor(s2, v), ConstructorP(s1, p)) = if s1 = s2
													  then match (v, p)
													  else NONE 
  | match _ = NONE


(* first_match - Retuns SOME list of bidings (string * valu), of the first match, or NONE if there's no valid bindings.
 *
 * Return Types:
 * fn : (valu * pattern) -> (string * valu) list option *)
fun first_match v ps = 
	case ps of
		[] => NONE
	  | p::ps' => (SOME (first_answer match [(v, p)])) handle NoAnswer => first_match v ps'
	


(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string


(* typecheck_patterns - Type-checks a pattern list for a common type between all, returns the "most general" type for all patterns, if it exists.
 *
 * Return Types:
 * fn : ((string * string * typ) list) * (pattern list) -> typ option *)
fun typecheck_patterns (ts, ps) = SOME Anything
		
