(* Test File for Extra Practice Problems of Week 2 *)

use "extra_practice_problems.sml";

val test_alternate_1 = alternate([1,2,3,4,5]) = SOME 3;
val test_alternate_2 = alternate([5,4,3,2,1]) = SOME 3;
val test_alternate_3 = alternate([1,2,3,4]) = SOME ~2;
val test_alternate_4 = alternate([4,3,2,1]) = SOME 2;
val test_alternate_5 = alternate([1]) = SOME 1;
val test_alternate_6 = alternate([]) = NONE;

val test_min_max_1 = min_max([1,2,3,4,5]) = (1,5);
val test_min_max_2 = min_max([4,5,1,3,5]) = (1,5);
val test_min_max_3 = min_max([16,22,34,43,15]) = (15, 43);
val test_min_max_4 = min_max([1,2]) = (1,2);
val test_min_max_5 = min_max([1]) = (1,1);

val test_cumsum_1 = cumsum([1,2,3,4,5]) = SOME [1,3,6,10,15];
val test_cumsum_2 = cumsum([1,2,3,4]) = SOME [1,3,6,10];
val test_cumsum_3 = cumsum([1,~2,3,4,5]) = SOME [1,~1,2,6,11];
val test_cumsum_4 = cumsum([1,2]) = SOME [1,3];
val test_cumsum_5 = cumsum([1]) = SOME [1];
val test_cumsum_6 = cumsum([]) = NONE;

val test_greeting_1 = greeting(SOME "José") = "Hello There, José!";
val test_greeting_2 = greeting(SOME " ") = "Hello There,  !";
val test_greeting_3 = greeting(SOME "") = "Hello There, !";
val test_greeting_4 = greeting(NONE) = "Hello There, you!";

val test_repeat_1 = repeat([1,2,3],[4,0,3]) = [1,1,1,1,3,3,3];
val test_repeat_2 = repeat([1,2,~3,15],[2,1,3,2]) = [1,1,2,~3,~3,~3,15,15];
val test_repeat_3 = repeat([1,2,3],[4,0,0]) = [1,1,1,1];
val test_repeat_4 = repeat([1,2,3],[0,0,0]) = [];
val test_repeat_5 = repeat([1],[2]) = [1,1];
val test_repeat_6 = repeat([],[]) = [];

val test_addOpt_1 = addOpt(SOME 2, SOME 4) = SOME 6;
val test_addOpt_2 = addOpt(SOME 2, SOME ~4) = SOME ~2;
val test_addOpt_3 = addOpt(SOME 2, NONE) = NONE;
val test_addOpt_4 = addOpt(NONE, SOME 4) = NONE;
val test_addOpt_5 = addOpt(NONE, NONE) = NONE;

val test_addAllOpt_1 = addAllOpt([SOME 1, SOME 2, SOME 3, SOME 4]) = SOME 10;
val test_addAllOpt_2 = addAllOpt([SOME 1, SOME 2, SOME 3]) = SOME 6;
val test_addAllOpt_3 = addAllOpt([SOME 1, SOME 2, SOME ~3]) = SOME 0;
val test_addAllOpt_4 = addAllOpt([SOME 1, NONE, SOME 3]) = SOME 4;
val test_addAllOpt_5 = addAllOpt([NONE, SOME 2, SOME 3]) = SOME 5;
val test_addAllOpt_6 = addAllOpt([SOME 1, SOME 2, NONE]) = SOME 3;
val test_addAllOpt_7 = addAllOpt([NONE, NONE, SOME 3]) = SOME 3;
val test_addAllOpt_8 = addAllOpt([SOME 1]) = SOME 1;
val test_addAllOpt_9 = addAllOpt([NONE]) = NONE;
val test_addAllOpt_10 = addAllOpt([]) = NONE;

val test_any_1 = any([false,false,false,true]) = true;
val test_any_2 = any([false,false,false]) = false;
val test_any_3 = any([true,false]) = true;
val test_any_4 = any([false,true]) = true;
val test_any_5 = any([false]) = false;
val test_any_6 = any([true]) = true;
val test_any_7 = any([]) = false;

val test_all_1 = all([true,true,true]) = true;
val test_all_2 = all([true,true,false]) = false;
val test_all_3 = all([false,true,true]) = false;
val test_all_4 = all([true]) = true;
val test_all_5 = all([false]) = false;
val test_all_6 = all([]) = false;

val test_zip_1 = zip([1,2],[3,4]) = [(1,3), (2,4)];
val test_zip_2 = zip([1,2,3],[4,5]) = [(1,4), (2,5)];
val test_zip_3 = zip([1,2],[3,4,5]) = [(1,3), (2,4)];
val test_zip_4 = zip([1],[2,3,4]) = [(1,2)];
val test_zip_5 = zip([1,2,3],[4]) = [(1,4)];
val test_zip_6 = zip([],[1,2]) = [];
val test_zip_7 = zip([1,2,3],[]) = [];

val test_zip_recycle_1 = zipRecycle([1,2,3], [1, 2, 3, 4, 5, 6, 7]) = [(1,1), (2,2), (3, 3), (1,4), (2,5), (3,6), (1,7)];
val test_zip_recycle_2 = zipRecycle([1, 2, 3, 4, 5, 6, 7], [1,2,3]) = [(1,1),(2,2),(3,3),(4,1),(5,2),(6,3),(7,1)];
val test_zip_recycle_3 = zipRecycle([1, 2, 3, 4, 5], [1]) = [(1,1),(2,1),(3,1),(4,1),(5,1)];
val test_zip_recycle_4 = zipRecycle([1], [1, 2, 3, 4, 5]) = [(1,1),(1,2),(1,3),(1,4),(1,5)];
val test_zip_recycle_5 = zipRecycle([], [1, 2, 3, 4, 5]) = [];
val test_zip_recycle_6 = zipRecycle([1, 2, 3, 4, 5], []) = [];

val test_zip_opt_1 = zipOpt([1,2],[3,4]) = SOME ([(1,3), (2,4)]);
val test_zip_opt_2 = zipOpt([1,2],[]) = NONE;
val test_zip_opt_3 = zipOpt([],[3,4]) = NONE;
val test_zip_opt_4 = zipOpt([1, 2, 3, 4, 5, 6, 7], [1,2,3]) = NONE;

val test_lookup_1 = lookup([("sim", 0), ("nao", 1), ("uhum", 2)], "nao") = SOME 1
val test_lookup_2 = lookup([], "nao") = NONE
val test_lookup_3 = lookup([("sim", 0), ("nao", 1), ("uhum", 2)], "com certeza") = NONE

val test_splitup_1 = splitup([~1,0,1,2]) = ([~1], [0,1,2])
val test_splitup_2 = splitup([]) = ([], [])
val test_splitup_3 = splitup([~1,2,1,0,~2]) = ([~1,~2], [2,1,0])
val test_splitup_4 = splitup([2,1,0]) = ([], [2,1,0])

val test_splitAt_1 = splitAt([~15,0,8,2], 7) = ([~15,0,2], [8])
val test_splitAt_2 = splitAt([], 10) = ([], [])
val test_splitAt_3 = splitAt([6,~10,5,10,9,2], 5) = ([~10,2], [6,5,10,9])

val test_isSorted_1 = isSorted([]) = true
val test_isSorted_2 = isSorted([1]) = true
val test_isSorted_3 = isSorted([1,2]) = true
val test_isSorted_4 = isSorted([1,2,3,5,~2,5]) = false

val test_isAnySorted_1 = isAnySorted([]) = true
val test_isAnySorted_2 = isAnySorted([1]) = true
val test_isAnySorted_3 = isAnySorted([1,2,3]) = true
val test_isAnySorted_4 = isAnySorted([3,2,1]) = true
val test_isAnySorted_5 = isAnySorted([1,2,3,~1]) = false
val test_isAnySorted_6 = isAnySorted([1,2,3,~1,2,3]) = false
val test_isanysorted_7 = isAnySorted([2,3,2,1]) = false

val test_sortedMerge_1 = sortedMerge([], []) = []
val test_sortedMerge_2 = sortedMerge([1], []) = [1]
val test_sortedMerge_3 = sortedMerge([], [1]) = [1]
val test_sortedMerge_4 = sortedMerge([1], [2]) = [1,2]
val test_sortedMerge_5 = sortedMerge([1,5,7], [2,3,8]) = [1,2,3,5,7,8]
val test_sortedMerge_6 = sortedMerge([1,5,7], [2,3]) = [1,2,3,5,7]
val test_sortedMerge_7 = sortedMerge([1,5], [2,3,8]) = [1,2,3,5,8]


val test_qsort_1 = qsort([5,1,543,7,43,987,321])
val test_qsort_1_res = isSorted(test_qsort_1) = true
val test_qsort_2 = qsort([])	
val test_qsort_2_res = isSorted(test_qsort_2)
val test_qsort_3 = qsort([5])
val test_qsort_3_res = isSorted(test_qsort_3)
val test_qsort_4 = qsort([5,1])
val test_qsort_4_res = isSorted(test_qsort_4)
val test_qsort_5 = qsort([5,1,543,7])
val test_qsort_5_res = isSorted(test_qsort_5) = true

val test_divide_1 = divide [] = ([], [])
val test_divide_2 = divide [1] = ([1], [])
val test_divide_3 = divide [1,2] = ([1], [2])
val test_divide_4 = divide [1,2,3] = ([1,3], [2])
val test_divide_5 = divide [1,2,3,4] = ([1,3], [2,4])
val test_divide_6 = divide [1,4,2,5,3] = ([1,2,3], [4,5])

val test_fullDivide_1 = fullDivide(2, 40) = (3, 5)
val test_fullDivide_2 = fullDivide(3, 10) = (0, 10)
val test_fullDivide_3 = fullDivide(3, 117) = (2, 13)

val test_factorize_1 = factorize 40 = [(2,3),(5,1)]
val test_factorize_2 = factorize 10 = [(2,1),(5,1)]
val test_factorize_3 = factorize 117 = [(3,2),(13,1)]
val test_factorize_4 = factorize 585 = [(3,2),(5,1),(13,1)]
val test_factorize_5 = factorize 1619352 = [(2,3),(3,5),(7,2),(17,1)]

val test_multiply_1 = multiply [(2,3),(5,1)] = 40
val test_multiply_2 = multiply [(2,1),(5,1)] = 10
val test_multiply_3 = multiply [(3,2),(13,1)] = 117
val test_multiply_4 = multiply [(3,2),(5,1),(13,1)] = 585
val test_multiply_5 = multiply [(2,3),(3,5),(7,2),(17,1)] = 1619352

val test_all_products_1 = all_products [] = [1]
val test_all_products_2 = all_products [(2,2),(5,1)] = [1,2,4,5,10,20]
val test_all_products_3 = all_products [(2,3)] = [1,2,4,8]
