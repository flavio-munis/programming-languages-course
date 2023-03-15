(* Homework 1 - Programming Languages Part A
 * Author: Flávio Muniz
 * Date: 15/03/2023 *)

(* Exercise 1 - Find which is the older date.
 * If date1 is the oldest, return true.
 * If date2 is the oldest or the 2 dates are the same, return false.
 *
 * Return Type:
 * fn : (int * int * int) * (int * int * int) -> bool *)
fun is_older(date1 : int * int * int, date2 : (int * int * int)) =

	if #1 date1 < #1 date2
	then true
	else
		if (#1 date1 > #1 date2) orelse (#2 date1 > #2 date2)
		then false
		else
			if (#2 date1 = #2 date2) andalso (#3 date1 >= #3 date2)
			then false
			else true

(* Exercise 2 - Given a list of dates and a month, returns how many dates on the list are in the given month.
 *
 * Return Type:
 * fn : (int * int * int) list * int -> int *)
fun number_in_month(dates : (int * int * int) list, month : int) =

	if null dates
	then 0
	else
		if #2 (hd dates) = month
		then 1 + number_in_month(tl dates, month)
		else number_in_month(tl dates, month)

(* Exercise 3 - Given a list of dates and a list of months, returns how many dates on the list are in the given months.
 * Assume the list of months has no repeated value.
 * 
 * Return Type:
 * fn : (int * int * int) list * int list -> int *)
fun number_in_months(dates : (int * int * int) list, months : int list) =

	if null months orelse null dates
	then 0
	else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* Exercise 4 - Takes a list of dates and a month, returns a list holding all dates that are in the given month.
 * The order in which the dates appear in the parameter list should be preserved.
 * 
 * Return Type:
 * fn : (int * int * int) list * int -> (int * int * int) list *)
fun dates_in_month(dates : (int * int * int) list, month : int) =

	if null dates
	then []
	else
		if #2 (hd dates) = month
		then hd dates :: dates_in_month(tl dates, month)
		else dates_in_month(tl dates, month)

(* Exercise 5 - Takes a list of dates and a list of months, returns a list holding all dates that are in the given months.
 * Assume the list of months has no repeated value.
 *
 * Return Type:
 * fn : (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_months(dates : (int * int * int) list, months : int list) =

	if null dates orelse null months
	then []
	else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* Exercise 6 - Takes a list of strings and a int n. Return the nth element from list. 
 * The head of the list is the 1st element.
 * Don't have to worry about cases where list has to few elements.
 *
 * Return Type:
 * fn : string list * int -> string *)
fun get_nth(strings : string list, n : int) =

	if n = 1
	then hd strings
	else get_nth(tl strings, n - 1)

(* Exercise 7 - Converts a date to a string.
 *
 * Return Type:
 * fn : (int * int * int) -> string *)
fun date_to_string(date : (int * int * int)) =

	let
		val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	in
		get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
	end

(* Exercise 8 - Takes a list of integers and a int x. Returns a int n, which represents the nths elements of the list that sum to less or equal to x. Considering also that n + 1 should be greater than x.
 * Assume the list only contains positive values.
 * Assume that the sum of all elements in the list is greater than x
 *
 * Return Type:
 * fn : int * int list -> int *)
fun number_before_reaching_sum(x : int, num_list : int list) =

	let
		fun sum_list_to_x(num_list_temp : int list, sum : int) =

			if sum >= x
			then 0
			else 1 + sum_list_to_x(tl num_list_temp, sum + hd num_list_temp)
	in
		sum_list_to_x(tl num_list, hd num_list)
	end

(* Exercise 9 - Takes a number between 1 - 365 and returns the month in which the date is in.
 * Assume the number is in the correct range.
 * 
 * Result Type:
 * fn : int -> int *)
fun what_month(day : int) =

	let
		val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	in
		1 + number_before_reaching_sum(day, months)
	end

(* Exercise 10 - Takes 2 days of the year and returns an int list containing all days in between the two dates written as it corresponding month.
 * 
 * Result Type:
 * fn : int * int -> int list *)
fun month_range(day1 : int, day2 : int) =

	let
		fun count(from : int) =

			if from > day2
			then []
			else what_month(from) :: count(1 + from)
	in
		count(day1)
	end

(* Exercise 11 - Takes a date list and returns a option.
 * Returns NONE if list has no dates
 * Returns SOME date if list has dates
 * 
 * Return Type:
 * fn : (int * int * int) list -> (int * int *int) option*)
fun oldest(dates : (int * int * int) list) =

	if null dates
	then NONE
	else
		let
			fun oldest_date(dates_temp : (int * int * int) list) =

				if null (tl dates_temp)
				then hd dates_temp
				else
					let
						val ans = oldest_date(tl dates_temp)
					in
						if is_older(ans, hd dates_temp)
						then ans
						else hd dates_temp
					end
		in
			SOME(oldest_date(dates))
		end

			
(* Challenge Exercises*)

(* Exercise 12 - Rewrite number_in_months and date_in_months to effective remove duplicates months from list.*)

(* Helper Function - Removes duplicated numbers from a list
 *
 * Return Type:
 * fn : int list -> int list*)
fun remove_duplicates(xs : int list) =

	if null xs
	then []
	else
		let
			fun search_in_list(ys : int list, n : int) =

				if null ys
				then false
				else
					if hd ys = n
					then true
					else search_in_list(tl ys, n)

			fun create_no_duplicate_list(ys : int list, result : int list) =

				if null ys
				then result
				else
					if search_in_list(result, hd ys)
					then create_no_duplicate_list(tl ys, result)
					else create_no_duplicate_list(tl ys, result @ [hd ys])

		in
			create_no_duplicate_list(xs, [])
		end
			
(* Exercise 12.1 - Given a list of dates and a list of months, returns how many dates on the list are in the given months.
 * 
 * Return Type:
 * fn : (int * int * int) list * int list -> int *)
fun number_in_months_challenge(dates : (int * int * int) list, months : int list) =

	if null months orelse null dates
	then 0
	else
		let
			fun without_duplicates(months_temp : int list) =

				if null months_temp
				then 0
				else number_in_month(dates, hd months_temp) + without_duplicates(tl months_temp)
		in
			without_duplicates(remove_duplicates(months))
		end
																
(* Exercise 12.2 - Takes a list of dates and a list of months, returns a list holding all dates that are in the given months.
 *
 * Return Type:
 * fn : (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_months_challenge(dates : (int * int * int) list, months : int list) =

	if null dates orelse null months
	then []
	else
		let
			fun without_duplicates(months_temp : int list) =

				if null months_temp
				then []
				else dates_in_month(dates, hd months_temp) @ without_duplicates(tl months_temp)
		in
			without_duplicates(remove_duplicates(months))
		end

(* Exercise 13 Helper Function - Converts a month and date format to only day format (1 - 365)
 *
 * Result Type:
 * fn : int * int -> int*)
fun convert_to_day(month : int, day : int) =
	
	let
		val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		
		fun sum_list_until(months_temp : int list, stop_index : int) =

			if stop_index = 1
			then 0
			else hd months_temp + sum_list_until(tl months_temp, stop_index - 1)

	in
		sum_list_until(months, month) + day
	end
		
(* Exercise 13 - Takes a date as input and analyzes if it is a valid date
 *
 * Return Type:
 * fn : (int * int * int) -> bool*)
fun reasonable_date(date : (int * int * int)) =

	if (#1 date <= 0) orelse (#2 date < 1) orelse (#2 date > 12) orelse (#3 date < 1) orelse (#3 date > 31)
	then false
	else
		if #2 date <> 2
		then
			if what_month(convert_to_day(#2 date, #3 date)) <> #2 date
			then false
			else true
		else
			if (#3 date < 1) orelse (#3 date > 29)
			then false
			else
				if #3 date <> 29
				then true
				else (#1 date mod 400 = 0) orelse ((#1 date mod 4 = 0) andalso (#1 date mod 100 <> 0))
