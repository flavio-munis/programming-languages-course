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
