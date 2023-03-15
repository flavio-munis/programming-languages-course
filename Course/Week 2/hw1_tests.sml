(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val test1 = is_older((1,2,3),(2,3,4)) = true;
val test1_2 = is_older((5,4,3),(5,6,7)) = true;
val test1_3 = is_older((5,4,3),(5,5,4)) = true;
val test1_4 = is_older((5,4,3),(5,4,3)) = false;
val test1_5 = is_older((5,4,3),(4,3,3)) = false;
val test1_6 = is_older((5,4,3),(5,3,3)) = false;
val test1_7 = is_older((5,4,3),(5,4,2)) = false;

val test2 = number_in_month([(2012,2,28),(2013,12,1)],2) = 1;
val test2_1 = number_in_month([(2012,2,28),(2013,2,1), (2014,2,2)],2) = 3;
val test2_2 = number_in_month([(2012,3,28),(2013,12,1)],2) = 0;
val test2_3 = number_in_month([(2012,3,12)],2) = 0;
val test2_4 = number_in_month([],2) = 0;

val test3 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3;
val test3_1 = number_in_months([(2012,2,28)],[2,3,4]) = 1;
val test3_2 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,2,28)],[2]) = 2;																				val test3_3 = number_in_months([(2012,7,28),(2013,12,1),(2011,6,31),(2011,5,28)],[2,3,4]) = 0;
val test3_4 = number_in_months([],[2,3,4]) = 0;
val test3_5 = number_in_months([(2012,7,28),(2013,12,1),(2011,6,31),(2011,5,28)],[]) = 0;
																					   
val test4 = dates_in_month([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)];
val test4_1 = dates_in_month([(2012,2,28),(2013,2,1)],2) = [(2012,2,28), (2013,2,1)];															   
val test4_2 = dates_in_month([(2012,2,28),(2022,5,4),(2013,2,1)],2) = [(2012,2,28), (2013,2,1)];
val test4_3 = dates_in_month([(2010,3,12),(2012,2,28),(2013,2,1)],2) = [(2012,2,28), (2013,2,1)];
val test4_4 = dates_in_month([(2013,2,16),(2010,3,12),(2012,2,28),(2013,2,1),(2022,5,4)],2) = [(2013,2,16),(2012,2,28), (2013,2,1)];
val test4_5 = dates_in_month([(2012,2,28),(2013,2,1)],4) = [];
val test4_6 = dates_in_month([(2012,2,28)],2) = [(2012,2,28)];
val test4_7 = dates_in_month([],2) = [];

val test5 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)];
val test5_1 = dates_in_months([(2012,2,28),(2013,3,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2013,3,1),(2011,3,31),(2011,4,28)];
val test5_2 = dates_in_months([(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)];
val test5_3 = dates_in_months([(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28)],[3,4,2]) = [(2011,3,31),(2011,4,28),(2012,2,28)];
val test5_4 = dates_in_months([(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28)],[2]) = [(2012,2,28)];
val test5_5 = dates_in_months([(2013,12,1),(2011,7,31),(2011,6,28),(2012,5,28)],[3,4,2]) = [];
val test5_6 = dates_in_months([(2011,3,31)],[3,4,2]) = [(2011,3,31)];
val test5_7 = dates_in_months([],[3,4,2]) = [];
val test5_8 = dates_in_months([(2011,3,31)],[]) = [];
val test5_9 = dates_in_months([],[]) = [];

val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there";
val test6_1 = get_nth(["hi", "how"], 2) = "how";
val test6_2 = get_nth(["hi", "how"], 1) = "hi";

val test7 = date_to_string(2013, 6, 1) = "June 1, 2013";
val test7_1 = date_to_string(2011, 1, 15) = "January 15, 2011";
val test7_2 = date_to_string(2018, 12, 25) = "December 25, 2018";
												
val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3;
val test8_1 = number_before_reaching_sum (1, [1,2,3,4,5]) = 0;
val test8_2 = number_before_reaching_sum (3, [1,2,3,4,5]) = 1;
val test8_3 = number_before_reaching_sum (6, [1,2,3,4,5]) = 2;

val test9 = what_month 70 = 3;
val test9_1 = what_month 1 = 1;
val test9_2 = what_month 31 = 1;
val test9_3 = what_month 32 = 2;
val test9_4 = what_month 59 = 2;
val test9_5 = what_month 60 = 3;
val test9_6 = what_month 90 = 3;
val test9_7 = what_month 91 = 4;
val test9_8 = what_month 120 = 4;
val test9_9 = what_month 121 = 5;
val test9_10 = what_month 151 = 5;
val test9_11 = what_month 152 = 6;
val test9_12 = what_month 181 = 6;
val test9_13 = what_month 182 = 7;
val test9_14 = what_month 212 = 7;
val test9_15 = what_month 213 = 8;
val test9_16 = what_month 243 = 8;
val test9_17 = what_month 244 = 9;
val test9_18 = what_month 273 = 9;
val test9_19 = what_month 274 = 10;
val test9_20 = what_month 304 = 10;
val test9_21 = what_month 305 = 11;
val test9_22 = what_month 334 = 11;
val test9_23 = what_month 335 = 12;
val test9_24 = what_month 365 = 12;

val test10 = month_range(134, 140) = [5,5,5,5,5,5,5];
val test10_1 = month_range(35, 34) = [];
val test10_2 = month_range(31, 34) = [1,2,2,2];
val test10_3 = month_range(243, 243) = [8];

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME(2011,3,31);
val test11_1 = oldest([(2012,2,28)]) = SOME(2012,2,28);
val test11_2 = oldest([]) = NONE;

(*val test12 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3;*)

(*val test13 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]*)

(*val test14_1 = reasonable_date(2022, 5, 31) = true;*)

(*val test14_2 = reasonable_date(0, 4, 31) = false;*)

(*val test14_3 = reasonable_date(1, 2, 3) = true;*)

(*val test14_4 = reasonable_date(2022, 11, 31) = false;*)

(*val test14_5 = reasonable_date(2022, 13, 3) = false;*)
