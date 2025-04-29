(* compose_opt - composes two functions with "optional" values. If either function returns NONE, then the result is NONE.
 *
 * Return Types:
 * fn : ('b -> 'c option) -> ('a -> 'b option) -> 'a -> 'c option *)
fun compose_opt f g x =
	let
		val g_x = g x
	in
		 case g_x of
			 NONE   => NONE
		   | SOME v => f v
	end


(* do_until - Apply f to α until p α is false.
 *
 * Return Types:
 * fn : ('a -> 'a) -> ('a -> bool) -> 'a -> 'a *)
fun do_until f p alpha = 
	if not (p alpha)
	then alpha
	else do_until f p (f alpha)

exception NegativeInput

(* factorial - Return n! for n > 0.
 *
 * Return Types:
 * fn : int -> int *)
fun factorial n =
	if n < 0
	then raise NegativeInput
	else
		let
			val (_, res) = do_until (fn (i, x) => (i - 1, x * i)) 
									(fn (i, _) => i > 1) 
									(n, 1)
		in
			res
		end

(* do_until2 - Apply f to α until p α is false and return a list containing every f x iteration.
 *
 * Return Types:
 * fn : ('a -> 'a) -> ('a -> bool) -> 'a -> 'a list *)
fun do_until2 f p alpha = 
	if not (p alpha)
	then []
	else 
		let
			val res = f alpha
		in
			res::(do_until2 f p res)
		end


(* collatz - Apply the Collatz Function.
 *
 * Return Types:
 * fn : int -> int list *)
val collatz = do_until2 (fn n => if n mod 2 = 0 then n div 2 else 3*n + 1) 
						(fn n => n <> 1)


(* factorize - Return all factors of a number.
 *
 * Return Types:
 * fn : int -> (int * int) list *)
fun factorize 0 = []
  | factorize n = 
	if n < 0
	then raise NegativeInput
	else
		let
			val limit = (Math.sqrt o Real.fromInt) n
								  
			fun aux (1, _) = []
			  | aux (n', d) = 
				if Real.fromInt d >= limit
				then [(n', 1)]
				else
					let
						val f_x = (fn (x, count) => (x div d, count + 1))
						val p_x = (fn (x, _) => x mod d = 0)
						val res = do_until f_x p_x (n', 0)

						val updateD = if d mod 2 <> 0 then d + 2 else d + 1
					in
						case res of
							(_, 0) => aux (n', updateD)
						  | (new_n, count) => (d, count)::aux (new_n, updateD)
					end
		in
			aux (n, 2)
		end


(* app_all - Concatenates all results of f g x into a single list.
 *
 * Return Types:
 * fn : ('b -> 'c list) -> ('a -> 'b list) -> 'a -> 'c list *)
fun app_all f g x =
	let
		fun aux (acc, []) = acc
		  | aux (acc, x'::xs') = aux (acc@(f x'), xs')
	in
		aux ([], (g x))
	end

(* my_foldr - Implements List.foldr.
 *
 * Return Types:
 * fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun my_foldr f seed xs =
	case xs of
		[]     => seed
	  | x::xs' => f (x, my_foldr f seed xs')


(* partition - Divide a list xs between (f x = true) list * (f x = false)
 *
 * Return Types:
 * fn : ('a -> bool) -> 'a list -> 'a list * 'a list *)
fun partition f xs =
	let
		fun p (x, acc) =
			let
				val res = f x
			in
				case acc of
					(t, f) => if res
							  then (x::t, f)
							  else (t, x::f)
			end
	in
		my_foldr p ([], []) xs
	end 


(* unfold - Reverse of fold, given a seed 'a produces a 'b list using a function f.
 *
 * Return Types:
 * fn : ('a -> ('b * 'a) option) -> 'a -> 'b list *)
fun unfold f seed =
	case f seed of
		NONE => []
	  | SOME (v, seed') => v::(unfold f seed')


(* factorial2 - Return n! for n > 0.
 *
 * Return Types:
 * fn : int -> int *)
fun factorial2 n =
	if n < 0
	then raise NegativeInput
	else 
		let
			val countdown =  unfold (fn x => if x > 1 then SOME (x, x-1) else NONE) n
		in
			my_foldr (fn (x, seed) => x * seed) 1 countdown
		end


(* my_map - Implement List.map using my_foldr.
 *
 * Return Types:
 * fn : ('a -> 'b) -> 'a list -> 'b list *)
fun my_map f xs = my_foldr (fn (x, s) => (f x)::s) [] xs


(* my_filter - Implement List.filter using my_foldr.
 *
 * Return Types:
 * fn : ('a -> bool) -> 'a list -> 'a list *)
fun my_filter f xs = my_foldr (fn (x, s) => if (f x) then x::s else s) [] xs


(* my_foldl - Implement List.foldl using my_foldr.
 *
 * Return Types:
 * fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun my_foldl f seed xs =
	let
		fun make_funcs xs_aux acc =
			case xs_aux of
				[]     => acc
			  | x::xs' => make_funcs xs' ((fn acc' => f(x, acc'))::acc)
	
		val funcs = make_funcs xs []
	in
		my_foldr (fn (f', prev) => f' prev) seed funcs
	end


datatype 'a tree = Leaf
				 | Node of 'a * 'a tree * 'a tree


(* tree_fold - Implement fold over a Binary Tree.
 *
 * Return Types:
 * fn : ('a tree * 'b * 'b -> 'b) -> 'b -> 'a tree -> 'b *)
fun tree_fold f seed t =
	case t of
		Leaf => seed
	  | Node (v, l, r) => f (v, (tree_fold f seed l), (tree_fold f seed r))



(* tree_map - Implement map over a Binary Tree.
 *
 * Return Types:
 * fn : ('a * 'b -> 'b) -> 'a tree -> 'b tree *)
fun tree_map f t =
	case t of
		Leaf => Leaf
	  | Node (v, l, r) => Node (f v, (tree_map f l), (tree_map f r)) 


(* tree_filter - Implement map over a Binary Tree.
 *
 * Return Types:
 * fn : ('a * bool -> bool) -> 'a tree -> 'a tree *)
fun tree_filter f t =
	case t of
		Leaf => Leaf
	  | Node (v, l, r) => if f v
						  then Node (v, (tree_filter f l), (tree_filter f r)) 
						  else Leaf
