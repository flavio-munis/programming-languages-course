
use "hw3_extra_problems.sml";

val f_compose_opt_1 = fn x => if x = 3 then SOME 4 else NONE
val g_compose_opt_1 = fn x => if x = 2 then SOME 3 else NONE

val test_compose_opt_1 = compose_opt f_compose_opt_1 g_compose_opt_1 2 = SOME 4
val test_compose_opt_2 = compose_opt f_compose_opt_1 g_compose_opt_1 3 = NONE

val f_compose_opt_2 = fn x => if x = 2 then SOME 4 else NONE

val test_compose_opt_3 = compose_opt f_compose_opt_2 g_compose_opt_1 2 = NONE


val f_do_until_1 = fn x => x div 2
val p_do_until_1 = fn x => x mod 2 <> 1 andalso x > 0

val test_do_until_1 = do_until f_do_until_1 p_do_until_1 10 = 5
val test_do_until_2 = do_until f_do_until_1 p_do_until_1 15 = 15
val test_do_until_3 = do_until f_do_until_1 p_do_until_1 18 = 9
val test_do_until_4 = do_until f_do_until_1 p_do_until_1 2 = 1
val test_do_until_5 = do_until f_do_until_1 p_do_until_1 0 = 0

val test_factorial_1 = factorial 1 = 1
val test_factorial_2 = factorial 2 = 2
val test_factorial_3 = factorial 5 = 120
val test_factorial_4 = ((factorial ~1; false) handle NegativeInput => true)

val test_collatz_1 = collatz 10
val test_collatz_2 = collatz 66547

val test_factorize_1 = factorize 40  = [(2,3),(5,1)]
val test_factorize_2 = factorize 10  = [(2,1),(5,1)]
val test_factorize_3 = factorize 117 = [(3,2),(13,1)]
val test_factorize_4 = factorize 585 = [(3,2),(5,1),(13,1)]
val test_factorize_5 = factorize 1619352 = [(2,3),(3,5),(7,2),(17,1)]


fun f_app_all_1 n = [n, n*2, n*3]

val test_app_all_1 = app_all f_app_all_1 f_app_all_1 1 = [1,2,3,2,4,6,3,6,9]
val test_app_all_2 = app_all f_app_all_1 f_app_all_1 2 = [2,4,6,4,8,12,6,12,18]
val test_app_all_3 = app_all f_app_all_1 (fn _ => []) 2 = []
val test_app_all_4 = app_all (fn _ => []) f_app_all_1 2 = []


val test_my_foldr_1 = my_foldr (fn (x, s) => x@s) [] [[1,2,3], [4,5,6]] = [1,2,3,4,5,6]


val f_partition = (fn x => x mod 2 = 0)

val test_partition_1 = partition f_partition [1,2,3,4,5,6,7,8] = ([2,4,6,8], [1,3,5,7])


val test_unfold_1 = unfold (fn n => if n = 0 then NONE else SOME(n, n-1)) 5 = [5, 4, 3, 2, 1]


val test_factorial2_1 = factorial2 1 = 1
val test_factorial2_2 = factorial2 2 = 2
val test_factorial2_3 = factorial2 5 = 120
val test_factorial2_4 = ((factorial2 ~1; false) handle NegativeInput => true)


val test_my_map_1 = my_map (fn x => x*2) [1,2,3,4,5,6] = [2,4,6,8,10,12]


val test_my_filter_1 = my_filter (fn x => x mod 2 = 0) [1,2,3,4,5,6] = [2,4,6]


val test_my_foldl_1 = my_foldl (fn (x, s) => x@s) [] [[1,2,3], [4,5,6]] = [4,5,6,1,2,3]


val test_tree_1 = Node(1, Node(2, Node (3, Leaf, Leaf), Leaf), Node(4, Leaf, Leaf))


(* sum *)
val test_tree_fold_1 = tree_fold (fn (v, l ,r) => v + l + r) 0 test_tree_1 = 10

(* size *)
val test_tree_fold_2 = tree_fold (fn (_, l ,r) => 1 + l + r) 0 test_tree_1 = 4

(* depth *)
val test_tree_fold_3 = tree_fold (fn (_, l ,r) => 1 + Int.max(l, r)) 0 test_tree_1 = 3


val test_tree_map_1 = tree_map (fn n => Real.fromInt n) test_tree_1 (* = Node(1.0, Node(2.0, Node (3.0, Leaf, Leaf), Leaf), Node(4.0, Leaf, Leaf))*)


val test_tree_filter_1 = tree_filter (fn x => x < 2) test_tree_1
