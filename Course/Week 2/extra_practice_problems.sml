(* Extra Practice Problems - Programming Languages Part A
 * Author: Flávio Muniz
 * Created Date: 16/03/2023 *)

(* 1. Alternate - Takes a list of numbers and adds them with a alternated sign.
 *
 * Return Type:
 * fn : int list -> int option *)
fun alternate (num_list : int list) =

	if null num_list
	then NONE
	else
		let
			fun count_list(num_list_temp : int list, should_be_positive : bool) =

				if null (tl num_list_temp)
				then
					if should_be_positive
					then hd num_list_temp
					else ~(hd num_list_temp)
				else
					if should_be_positive
					then hd num_list_temp + count_list(tl num_list_temp, false)
					else ~(hd num_list_temp) + count_list(tl num_list_temp, true)
		in
			SOME (count_list(num_list, true))
		end


(* 2. Min Max - Takes a int list and returns an pair containing the minimum and maximum values of the list.
 * Assume the list is non-empty
 *
 * Return Type:
 * fn : int list -> int * int *)
fun min_max (num_list : int list) =

	if null (tl num_list)
	then (hd num_list, hd num_list)
	else
		let
			val min_max_result = min_max(tl num_list)

			fun is_bigger(num1 : int, num2 : int) =
				num1 > num2
		in
			if #2 min_max_result < hd num_list
			then (#1 min_max_result, hd num_list)
			else
				if #1 min_max_result > hd num_list
				then (hd num_list, #2 min_max_result)
				else min_max_result
		end


(* 3. Partial Sum - Takes a int list and returns an int list option containing the partial sum of the original list.
 * 
 * Return Type: 
 * fn : int list -> int list option *)
fun cumsum (num_list : int list) =

	if null num_list
	then NONE
	else
		let
			fun sum_partial(num_list_temp : int list, partial_sum : int) =

				if null num_list_temp
				then [partial_sum]
				else partial_sum :: sum_partial(tl num_list_temp, hd num_list_temp + partial_sum)
		in
			SOME(sum_partial(tl num_list, hd num_list))
		end


(* 4. Greeting - Takes a string option and returns an greeting string 
 *
 * Return Type:
 * fn : string option -> string *)
fun greeting (name : string option) =

	let
		val name_used = if isSome name
						then valOf name
						else "you"
	in
		"Hello There, " ^ name_used ^ "!"
	end


(* 5. Repeat - Takes two int list and repeats the int contained in the firt list according with the numbers on the second list.
 * Assume the intergers on the second list are nonnegatives.
 * Assume both list contain the same length.
 *
 * Return Type:
 * fn : int list * int list -> int list *)
fun repeat (num_list : int list, times_to_repeat : int list) =

	if null num_list
	then []
	else
		let	
			fun repeat_number(repeat : int) =

				if repeat = 0
				then []
				else hd num_list :: repeat_number(repeat - 1)
		in
			repeat_number(hd times_to_repeat) @ repeat(tl num_list, tl times_to_repeat)
		end


(* 6. Add Options - Takes two int options, sums if both of them are not NONE, else just returns NONE
 *
 * Return Type:
 * fn : int option * int option -> int option *)
fun addOpt (num1 : int option, num2 : int option) =

	if isSome num1 andalso isSome num2
	then SOME(valOf num1 + valOf num2)
	else NONE


(* 7. Add All Options - Takes a int option list and adds all the values.
 * If there is no valid values in the list, the function should return NONE
 * 
 * Return Type:
 * fn : int option list : int option *)
fun addAllOpt (num_list : int option list) =

	if null num_list
	then NONE
	else
		let
			val sum = addAllOpt(tl num_list)
		in
			if isSome sum
			then
				if isSome (hd num_list)
				then SOME(valOf sum + valOf (hd num_list))
				else sum
			else
				if isSome (hd num_list)
				then hd num_list
				else NONE
		end


(* 8. Any - Takes a bool list and returns true if at least one element is true.
 * Empty Lists returns false cause there is no true in it.
 *
 * Return Type:
 * fn : bool list -> bool *)
fun any (bool_ls : bool list) =

	if null bool_ls
	then false
	else
		if hd bool_ls
		then true
		else any(tl bool_ls)


(* 9. All - Takes a bool list and returns true only if all elements are true. 
 *
 * Return Type:
 * fn : bool list -> bool *)
fun all (bool_ls : bool list) =

	if null bool_ls
	then false
	else
		if null (tl bool_ls)
		then hd bool_ls
		else
			if hd bool_ls
			then all(tl bool_ls)
			else false


(* 10. Zip - Takes two int lists and creates pairs with theirs firts elements.
 * Stops when one or both lists are empty.
 * 
 * Return Type:
 * fn : int list * int list -> (int * int) list *)
fun zip (num_lst1 : int list, num_lst2 : int list) =

	if null num_lst1 orelse null num_lst2
	then []
	else (hd num_lst1, hd num_lst2) :: zip(tl num_lst1, tl num_lst2)


(* 11. ZipRecycle - Does same thing than zip, but recycles the numbers from other list until both lists are empty
 *
 * Return Type:
 * fn : int list * int list -> (int * int) list *)
fun zipRecycle (xs : int list, ys : int list) =
	if null xs orelse null ys
	then []
	else
		let
			val xs_len = List.length xs
			val ys_len = List.length ys
			val max_length = if xs_len > ys_len then xs_len else ys_len

			fun recycle (xs_aux : int list, ys_aux : int list, len_aux : int) =
				if len_aux = 0
				then []
				else 
					if null xs_aux
					then recycle (xs, ys_aux, len_aux)
					else
						if null ys_aux
						then recycle (xs_aux, ys, len_aux)
						else (hd xs_aux, hd ys_aux)::recycle(tl xs_aux, tl ys_aux, len_aux - 1)
		in
			recycle(xs, ys, max_length)
		end
									   

(* 12. zipOpt - Return SOME (fn : zip) if the lists are the same length, and NONE if they are not.
 *
 * Return Type:
 * fn : int list * int list -> (int * int) list option*)
fun zipOpt (xs : int list, ys : int list) =
	if null xs orelse null ys
	then NONE
	else
		let
			val xs_len = List.length xs
			val ys_len = List.length ys
		in
			if xs_len = ys_len
			then SOME(zip(xs, ys))
			else NONE
		end


(* 13. lookup - Takes a List of Pairs (s1 : string * i : int) and a s2 : string to lookup in the list, returns SOME i if s2 is in the list and NONE if not. 
 *
 * Return Type:
 * fn : (string * int), string -> int option*)
fun lookup (xs : (string * int) list, s2 : string) =
	if null xs
	then NONE
	else
		if s2 = #1 (hd xs)
		then SOME (#2 (hd xs))
		else lookup(tl xs, s2)


(* 14. splitup - Split a int list into to two lists, one containing the negative entries and the other the positives ones, relative order must be preversed.
 *
 * Return Type:
 * fn : int list -> int list * int list*)
fun splitup (xs : int list) =
	if null xs
	then ([], [])
	else
		let
			val ans = splitup(tl xs) 
		in
			if (hd xs) < 0
			then ((hd xs)::(#1 ans), #2 ans)
			else (#1 ans, (hd xs)::(#2 ans))
		end

(* 15. splitAt - Same as splitup but receives a threshold value.
 *
 * Return Type:
 * fn : int list, int -> int list * int list*)
fun splitAt (xs : int list, th : int) =
	if null xs
	then ([], [])
	else
		let
			val ans = splitAt(tl xs, th) 
		in
			if (hd xs) < th
			then ((hd xs)::(#1 ans), #2 ans)
			else (#1 ans, (hd xs)::(#2 ans))
		end


(* 16. isSorted - Checks if a list is sorted in Incresing Order.
 *
 * Return Type:
 * fn : int list -> bool*)
fun isSorted (xs : int list) =
	if null xs orelse null (tl xs)
	then true
	else
		if hd xs > hd (tl xs)
		then false
		else isSorted(tl xs)


(* 17. isAnySorted - Checks if a list is sorted in Incresing or Decreasing Order.
 *
 * Return Type:
 * fn : int list -> bool*)
fun isAnySorted (xs : int list) =
	if null xs orelse null (tl xs)
	then true
	else
		let
			val incDecr = (true, true)

			fun checker (xs_aux : int list, values : (bool * bool)) =
				if null xs_aux orelse null (tl xs_aux) orelse (not (#1 values) andalso not (#2 values))
				then #1 values orelse #2 values
				else
					if #1 values andalso hd xs_aux > hd (tl xs_aux)
					then checker (tl xs_aux, (false, #2 values))
					else
						if #2 values andalso hd xs_aux < hd (tl xs_aux)
						then checker (tl xs_aux, (#1 values, false))
						else checker (tl xs_aux, values)

		in
			checker (xs, incDecr)
		end
		

(* 18. sortedMerge - Takes two lists and sort then into one sorted list in incresing order. Both lists must be sorted.
 *
 * Return Type:
 * fn : int list, int list -> int list*)
fun sortedMerge (xs : int list, ys : int list) =
	if null xs
	then ys
	else
		if null ys
		then xs
		else
			if hd xs < hd ys
			then hd xs :: sortedMerge(tl xs, ys)
			else hd ys :: sortedMerge(xs, tl ys)


(* 19. qSort - Implements Quick Sort.
 *
 * Return Type:
 * fn : int list -> int list*)
fun qsort (xs : int list) =
	if null xs
	then []
	else
		let
			val pivot = hd xs
			val lists = splitAt(tl xs, pivot)
			val list1 = qsort(#1 lists)
			val list2 = qsort(#2 lists)
		in
			list1 @ (pivot::list2)
		end


(* 20. divide - Divides a list of integers in 2.
 *
 * Return Type:
 * fn : int list -> (int list * int list)*)
fun divide (xs : int list) =
	if null xs
	then ([], [])
	else
		if null (tl xs)
		then ([hd xs], [])
		else 
			let
				val res = divide(tl (tl xs))
			in
				(hd xs::(#1 res), hd (tl xs)::(#2 res))
			end

(* 22. fullDivide - Divide n / k and return it's result and modulo.
 *
 * Return Type:
 * fn : int, int -> (int * int)*)
fun fullDivide (k : int, n : int) =
	if n mod k <> 0
	then (0, n)
	else
		let
			val ans = fullDivide(k, n div k)
		in
			(1 + (#1 ans), #2 ans)
		end

(* 23. factorize - Return all factors of a number.
 *
 * Return Type:
 * fn : int -> (int * int) list*)
fun factorize (n : int) =
	if n <= 1
	then []
	else
		let					 
			fun aux (n_aux : int, k : int, factors : (int * int) list) = 
				let 
					val n_real = Real.fromInt(n_aux)
					val limit = Math.sqrt n_real

					fun updateK (curr_k : int) =
						if curr_k mod 2 <> 0
						then curr_k + 2
						else curr_k + 1

				in
					if Real.fromInt(k) > limit
					then factors@[(n_aux, 1)]
					else
						if n_aux mod k <> 0
						then aux (n_aux, updateK k, factors)
						else 
							let
								val ans = fullDivide (k, n_aux)
							in
								aux (#2 ans, updateK k, factors@[(k, #1 ans)])			 
							end 
				end
		in
			aux (n, 2, [])
		end
		
(* 24. multiply - Return the number n product of a factorization.
 *
 * Return Type:
 * fn : (int * int) list -> int*)
fun multiply (fac : (int * int) list) =
	let

		fun exp (n : int, e : int) =
			if e = 1
			then n
			else n * exp (n, e - 1)

		fun aux (fac_aux : (int * int) list, res : int) =
			if null fac_aux
			then res
			else aux(tl fac_aux, res * exp (#1 (hd fac_aux), #2 (hd fac_aux)))
	in
		aux (fac, 1)
	end


(* 25. all_products - Return all products of a factorization (in increasing order).
 *
 * Return Type:
 * fn : (int * int) list -> int list*)
fun all_products (fac : (int * int) list) =
	let
		(* sortedMergeWithoutDupli - Apply sortedMerge function removing duplicated values.
		 * Return Type:
		 * fn : int list, int list -> int list*)
		fun sortedMergeWithoutDupli (xs : int list, ys : int list) =
			if null xs
			then ys
			else
				if null ys
				then xs
				else
					if hd xs = hd ys
					then sortedMergeWithoutDupli(tl xs, ys)
					else
						if hd xs < hd ys
						then hd xs :: sortedMergeWithoutDupli(tl xs, ys)
						else hd ys :: sortedMergeWithoutDupli(xs, tl ys)

		(* flat_list - Flattout a (int * int) list to a int list.
		 * Factorize Returns a (int * int) list where each pair (int * int) is of the form (n, exp) or n^exp, so flat_list transform the pair (n, exp) into a [..., n_0, n_1, ..., n_exp] list
		 * Return Type:
		 * fn : (int * int) list -> int list*)
		fun flat_list (xs : (int * int) list) =
			if null xs
			then []
			else 
				if #2 (hd xs) = 1
				then #1 (hd xs)::flat_list(tl xs)
				else #1 (hd xs)::flat_list((#1 (hd xs), #2 (hd xs) - 1)::tl xs)
										  
		(* genarete - Generate all possible combination using a binary decision tree approach, where each number in list is or isn't a factor, generating all possible multiples.
		 * Return Type: 
		 * fn : int list, int -> int list*)
		fun generate (xs : int list, product : int) =
			if null xs
			then [product]
			else
				let
					val with_curr = generate(tl xs, product * hd xs)
					val without_curr = generate(tl xs, product)
				in
					sortedMergeWithoutDupli (with_curr, without_curr)
				end
	in
		generate (flat_list fac, 1)
	end
