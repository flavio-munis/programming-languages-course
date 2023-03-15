(* Homework 1 - Programming Languages Part A
 * Author: Flávio Muniz
 * Date: 15/03/2023 *)

(* Exercise 1 - Find which is the older date.
 * If date1 is the oldest, return true.
 * If date2 is the oldest or the 2 dates are the same, return false.
 *
 * Return Type:
 * (int * int * int) * (int * int * int) -> bool*)
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
