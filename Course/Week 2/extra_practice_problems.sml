(* Extra Practice Problems - Programming Languages Part A
 * Author: Flávio Muniz
 * Date: 16/03/2023 *)

(* 1. Alternate - Takes a list of numbers and adds them with a alternated sign.
 *
 * Return Type:
 * fn : int list -> int option *)
fun alternate(num_list : int list) =

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
fun min_max(num_list : int list) =

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
fun cumsum(num_list : int list) =

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
fun greeting(name : string option) =

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
fun repeat(num_list : int list, times_to_repeat : int list) =

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
fun addOpt(num1 : int option, num2 : int option) =

	if isSome num1 andalso isSome num2
	then SOME(valOf num1 + valOf num2)
	else NONE

(* 7. Add All Options - Takes a int option list and adds all the values.
 * If there is no valid values in the list, the function should return NONE
 * 
 * Return Type:
 * fn : int option list : int option *)
fun addAllOpt(num_list : int option list) =

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
fun any(bool_ls : bool list) =

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
fun all(bool_ls : bool list) =

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
fun zip(num_lst1 : int list, num_lst2 : int list) =

	if null num_lst1 orelse null num_lst2
	then []
	else (hd num_lst1, hd num_lst2) :: zip(tl num_lst1, tl num_lst2)

(* 11. ZipRecycle - Does same thing than zip, but recycles the numbers from other list until both lists are empty
 *
 * Return Type:
 * fn : int list * int list -> (int * int) list *)
fun zipRecycle(num_lst1 : int list, num_lst2 : int list) =

	if null num_lst1 orelse null num_lst2
	then []
	else
		let
			fun isLst1Bigger(lst1_temp : int list, lst2_temp : int list) =

				if null lst1_temp
				then false
				else 
					if null lst2_temp
					then true
					else isLst1Bigger(tl lst1_temp, tl lst2_temp)

			val lst1_bigger = isLst1Bigger(num_lst1, num_lst2)
		in
			let
				fun recycle(lst1_temp : int list, lst2_temp : int list) =

					if lst1_bigger
					then
						if null lst1_temp
						then []
						else
							if null lst2_temp
							then recycle(lst1_temp, num_lst2)
							else (hd lst1_temp, hd lst2_temp) :: recycle(tl lst1_temp, tl lst2_temp)
					else
						if null lst2_temp
						then []
						else
							if null lst1_temp
							then recycle(num_lst1, lst2_temp)
							else (hd lst1_temp, hd lst2_temp) :: recycle(tl lst1_temp, tl lst2_temp)
			in
				recycle(num_lst1, num_lst2)
			end
		end
