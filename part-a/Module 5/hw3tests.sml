(* Homework3 Simple Test*)

use "hw3.sml";

val test_only_capitals_1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test_only_capitals_2 = only_capitals [] = []
val test_only_capitals_3 = only_capitals ["A","b","C"] = ["A","C"]
val test_only_capitals_4 = only_capitals ["A"] = ["A"]
val test_only_capitals_5 = only_capitals ["a","b","c"] = []

val test_longest_string1_1 = longest_string1 ["A","bc","C"] = "bc"
val test_longest_string1_2 = longest_string1 [] = ""
val test_longest_string1_3 = longest_string1 ["A","bc","Cb"] = "bc"
val test_longest_string1_4 = longest_string1 ["A", "Ab","bc","Cb"] = "Ab"
val test_longest_string1_5 = longest_string1 ["bc"] = "bc"

val test_longest_string2_1 = longest_string2 ["A","bc","C"] = "bc"
val test_longest_string2_2 = longest_string2 [] = ""
val test_longest_string2_3 = longest_string2 ["A","bc","Cb"] = "Cb"
val test_longest_string2_4 = longest_string2 ["A","bc","Cb", "De"] = "De"
val test_longest_string2_5 = longest_string2 ["bc"] = "bc"

val test_longest_string3_1 = longest_string3 ["A","bc","C"] = "bc"
val test_longest_string3_2 = longest_string3 [] = ""
val test_longest_string3_3 = longest_string3 ["A","bc","Cb"] = "bc"
val test_longest_string3_4 = longest_string3 ["A", "Ab","bc","Cb"] = "Ab"
val test_longest_string3_5 = longest_string3 ["bc"] = "bc"

val test_longest_string4_1 = longest_string4 ["A","bc","C"] = "bc"
val test_longest_string4_2 = longest_string4 [] = ""
val test_longest_string4_3 = longest_string4 ["A","bc","Cb"] = "Cb"
val test_longest_string4_4 = longest_string4 ["A","bc","Cb", "De"] = "De"
val test_longest_string4_5 = longest_string4 ["bc"] = "bc"

val test_longest_capitalized_1 = longest_capitalized ["A","bc","C"] = "A"
val test_longest_capitalized_2 = longest_capitalized [] = ""
val test_longest_capitalized_3 = longest_capitalized ["a","bc","c"] = ""
val test_longest_capitalized_4 = longest_capitalized ["A"] = "A"

val test_rev_string_1 = rev_string "abc" = "cba"
val test_rev_string_2 = rev_string "" = ""
val test_rev_string_3 = rev_string "a" = "a"
val test_rev_string_4 = rev_string "ab" = "ba"

val test_first_answer_1 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test_first_answer_2 = ((first_answer (fn x => if x > 3 then SOME x else NONE) []; false) handle NoAnswer => true)
val test_first_answer_3 = ((first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5]; false) handle NoAnswer => true)
val test_first_answer_4 = first_answer (fn x => if x = "SIM"  then SOME x else NONE) ["NÃO", "SIM"] = "SIM" 

val test_all_answers_1 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test_all_answers_2 = all_answers (fn x => if x > 2 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test_all_answers_3 = all_answers (fn x => if x >= 2 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]

val test_count_wildcards_1 = count_wildcards Wildcard = 1
val test_count_wildcards_2 = count_wildcards UnitP = 0
val test_count_wildcards_3 = count_wildcards (TupleP [Wildcard, UnitP, Wildcard]) = 2
val test_count_wildcards_4 = count_wildcards (TupleP []) = 0
val test_count_wildcards_5 = count_wildcards (ConstructorP ("sim", Wildcard)) = 1
val test_count_wildcards_6 = count_wildcards (ConstructorP ("sim", Variable "nao")) = 0

val test_count_wild_and_variable_lenghts_1 = count_wild_and_variable_lengths (Variable("a")) = 1
val test_count_wild_and_variable_lenghts_2 = count_wild_and_variable_lengths (TupleP [Wildcard, UnitP, Wildcard, Variable "sim"]) = 5
val test_count_wild_and_variable_lenghts_3 = count_wild_and_variable_lengths (TupleP [UnitP]) = 0

val test_count_some_var_1 = count_some_var ("x", Variable("x")) = 1
val test_count_some_var_2 = count_some_var ("x", (TupleP [Variable("x"), Variable "y"])) = 1
val test_count_some_var_3 = count_some_var ("x", (TupleP [Variable("z"), Variable "y", Wildcard, UnitP])) = 0

val test_check_pat_1 = check_pat (Variable("x")) = true
val test_check_pat_2 = check_pat Wildcard = true
val test_check_pat_3 = check_pat (TupleP [Variable "x", Variable "y"]) = true
val test_check_pat_4 = check_pat (TupleP [Variable "x", Variable "y", Variable "z"]) = true
val test_check_pat_5 = check_pat (TupleP [Variable "x", Variable "x", Variable "x"]) = false
val test_check_pat_6 = check_pat (TupleP [ConstructorP ("x", Variable "x"), Variable "y", Variable "z"]) = true
val test_check_pat_7 = check_pat (TupleP [ConstructorP ("x", Variable "y"), Variable "y", Variable "z"]) = false
val test_check_pat_8 = check_pat (TupleP [Variable "x"]) = true

val test_match_1 = match (Const(1), UnitP) = NONE
val test_match_2 = match (Const(1), Variable("sim")) = SOME [("sim", Const(1))]
val test_match_3 = match (Tuple[Const(1)], TupleP[Variable("sim")]) = SOME [("sim", Const(1))]
val test_match_4 = match (Tuple[Const(1), Unit], TupleP[Variable("sim"), Wildcard]) = SOME [("sim", Const(1))]
val test_match_5 = match (Tuple[Const(1)], TupleP[Variable("sim"), Wildcard]) = NONE
val test_match_6 = match (Tuple[Const(1), Const(2)], TupleP[Variable("sim"), Variable("nao")]) = SOME [("sim", Const(1)), ("nao", Const(2))]
val test_match_7 = match (Tuple[Const(1), Tuple[Const(2)]], TupleP[Variable("sim"), TupleP[Variable("nao")]]) = SOME [("sim", Const(1)), ("nao", Const(2))]
val test_match_8 = match (Constructor ("uhum", Tuple[Const(1), Tuple[Const(2)]]), ConstructorP("uhum", TupleP[Variable("sim"), TupleP[Variable("nao")]])) = SOME [("sim", Const(1)), ("nao", Const(2))]
val test_match_9 = match (Constructor ("", Tuple[Const(1), Tuple[Const(2)]]), ConstructorP("uhum", TupleP[Variable("sim"), TupleP[Variable("nao")]])) = NONE
val test_match_10 = match (Const(1), ConstP(1)) = SOME []
val test_match_11 = match (Const(2), ConstP(1)) = NONE
val test_match_12 = match (Tuple[Const 17,Unit,Const 4,Constructor ("egg",Const 4),Constructor ("egg",Constructor ("egg",Const 4)),Tuple[Const 17,Unit,Const 4,Constructor ("egg",Const 4),Constructor ("egg",Constructor ("egg",Const 4))],Tuple[Unit,Unit],Tuple[Const 17,Const 4],Tuple[Constructor ("egg",Const 4),Constructor ("egg",Const 4)]],TupleP[ConstP 17,Wildcard,ConstP 4,ConstructorP ("egg",ConstP 4),ConstructorP ("egg",ConstructorP ("egg",ConstP 4)),TupleP[ConstP 17,Wildcard,ConstP 4,ConstructorP ("egg",ConstP 4),ConstructorP ("egg",ConstructorP ("egg",ConstP 4))],TupleP[Wildcard,Wildcard],TupleP[ConstP 17,ConstP 4],TupleP[ConstructorP ("egg",ConstP 4),ConstructorP ("egg",ConstP 4)]]) = SOME []

val test_first_match1 = first_match Unit [UnitP] = SOME []

val test_typecheck_patterns_1 = typecheck_patterns ([("sim", "uhum", IntT)], [Variable "x"]);
