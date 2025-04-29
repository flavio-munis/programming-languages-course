(* Homework2 Simple Test *)

use "hw2.sml";

val test1_1 = all_except_option ("string", ["string"]) = SOME []
val test1_2 = all_except_option ("string", ["string1"]) = NONE
val test1_3 = all_except_option ("string", ["string1","string"]) = SOME ["string1"]
val test1_4 = all_except_option ("string", ["string1","string","string2"]) = SOME ["string1","string2"]
val test1_5 = all_except_option ("string", ["string","string1","string2"]) = SOME ["string1","string2"]
val test1_6 = all_except_option ("string", ["string1","string2","string"]) = SOME ["string1","string2"]
val test1_7 = all_except_option ("string", []) = NONE


val test2_1 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2_2 = get_substitutions1 ([["foo","bar"],["there"]], "foo") = ["bar"]
val test2_3 = get_substitutions1 ([["foo","bar"],["there","foo"]], "foo") = ["bar","there"]
val test2_4 = get_substitutions1 ([["there","foo"], ["foo","bar"]], "foo") = ["there", "bar"]
val test2_5 = get_substitutions1 ([["there", "foo","bar"]], "foo") = ["there", "bar"]
val test2_6 = get_substitutions1 ([], "foo") = []

val test3_1 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test3_2 = get_substitutions2 ([["foo","bar"],["there"]], "foo") = ["bar"]
val test3_3 = get_substitutions2 ([["foo","bar"],["there","foo"]], "foo") = ["bar","there"]
val test3_4 = get_substitutions2 ([["there","foo"], ["foo","bar"]], "foo") = ["there", "bar"]
val test3_5 = get_substitutions2 ([["there", "foo","bar"]], "foo") = ["there", "bar"]
val test3_6 = get_substitutions2 ([], "foo") = []


val test4_1 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5_1 = card_color (Clubs, Num 2) = Black
val test5_2 = card_color (Spades, Num 2) = Black
val test5_3 = card_color (Diamonds, Num 2) = Red
val test5_4 = card_color (Hearts, Num 2) = Red

val test6_1 = card_value (Clubs, Num 2) = 2
val test6_2 = card_value (Clubs, Ace) = 11
val test6_3 = card_value (Clubs, King) = 10

val test7_1 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7_2 = remove_card ([(Hearts, Ace), (Spades, King)], (Hearts, Ace), IllegalMove) = [(Spades, King)]
val test7_3 = remove_card ([(Hearts, Num 2),(Hearts, Ace), (Spades, King)], (Hearts, Ace), IllegalMove) = [(Hearts, Num 2),(Spades, King)]
val test7_4 = remove_card ([(Hearts, Num 2),(Hearts, Queen), (Spades, King)], (Hearts, Ace), IllegalMove) = [(Hearts, Num 2),(Hearts, Queen), (Spades, King)] handle IllegalMove => true

val test8_1 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8_2 = all_same_color [(Hearts, Ace)] = true
val test8_3 = all_same_color [] = true
val test8_4 = all_same_color [(Hearts, Ace), (Hearts, Ace), (Spades, Ace)] = false

val test9_1 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9_2 = sum_cards [(Clubs, Num 2)] = 2
val test9_3 = sum_cards [] = 0
val test9_4 = sum_cards [(Clubs, Num 2),(Clubs, Num 2),(Hearts,Ace)] = 15

val test10_1 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10_2 = score ([(Spades, Num 2),(Clubs, Num 4)],10) = 2
val test10_3 = score ([(Hearts, Num 2),(Clubs, Ace)],10) = 9
val test10_4 = score ([(Spades, Num 2),(Clubs, Ace)],10) = 4
val test10_5 = score([(Hearts, Ace)], 2) = 13;

val test11_1 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test11_2 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3
val test11_3 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
val test11_4 = officiate([], [Draw], 15) = 7
val test11_5 = officiate([(Clubs, Jack)], [], 15) = 7


(* One Ace *)
val test_score_challenge_1 = score_challenge ([(Hearts, Ace)], 2) = 0;
val test_score_challenge_2 = score_challenge ([(Hearts, Ace)], 3) = 1;
val test_score_challenge_3 = score_challenge ([(Hearts, Ace)], 4) = 1;
val test_score_challenge_4 = score_challenge ([(Hearts, Ace)], 5) = 2;
val test_score_challenge_5 = score_challenge ([(Hearts, Ace)], 6) = 2
val test_score_challenge_6 = score_challenge ([(Hearts, Ace)], 7) = 3
val test_score_challenge_7 = score_challenge ([(Hearts, Ace)], 8) = 3;
val test_score_challenge_8 = score_challenge ([(Hearts, Ace)], 9) = 3;
val test_score_challenge_9 = score_challenge ([(Hearts, Ace)], 10) = 1;
val test_score_challenge_10 = score_challenge ([(Hearts, Ace)], 11) = 0;
val test_score_challenge_11 = score_challenge ([(Hearts, Ace)], 12) = 0;
val test_score_challenge_12 = score_challenge ([(Hearts, Ace)], 13) = 1;

(* Tree Shifted by 1 position, So for a Non-Ace Sum = 0, The Three Will Shift N Positions*)
val test_score_challenge_13 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 2) = 0;
val test_score_challenge_14 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 3) = 0;
val test_score_challenge_15 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 4) = 1;
val test_score_challenge_16 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 5) = 1;
val test_score_challenge_17 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 6) = 2;
val test_score_challenge_18 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 7) = 2;
val test_score_challenge_19 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 8) = 3;
val test_score_challenge_20 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 9) = 3;
val test_score_challenge_21 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 10) = 3;
val test_score_challenge_22 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 11) = 1;
val test_score_challenge_23 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 12) = 0;
val test_score_challenge_24 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 13) = 0;
val test_score_challenge_25 = score_challenge ([(Hearts,Ace),(Hearts,Num 1)], 14) = 1;


(* Two Aces *)
val test_score_challenge_2_1 = score_challenge ([(Hearts,Ace),(Hearts,Ace)], 1) = 1;
val test_score_challenge_2_2 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 2) = 0;
val test_score_challenge_2_3 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 3) = 1;
val test_score_challenge_2_4 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 4) = 2;
val test_score_challenge_2_5 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 5) = 3;
val test_score_challenge_2_6 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 6) = 4
val test_score_challenge_2_7 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 7) = 5;
val test_score_challenge_2_8 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 8) = 6;
val test_score_challenge_2_9 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 9) = 7;
val test_score_challenge_2_10 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 10) = 6;
val test_score_challenge_2_11 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 11) = 3
val test_score_challenge_2_12 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 12) = 0;
val test_score_challenge_2_13 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 13) = 1;
val test_score_challenge_2_14 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 14) = 2;
val test_score_challenge_2_15 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 15) = 3;
val test_score_challenge_2_16 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 16) = 4;
val test_score_challenge_2_17 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 17) = 5;
val test_score_challenge_2_18 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 18) = 6
val test_score_challenge_2_19 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 19) = 7;
val test_score_challenge_2_20 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 20) = 6;
val test_score_challenge_2_21 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 21) = 3;
val test_score_challenge_2_22 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 22) = 0;
val test_score_challenge_2_23 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 23) = 1;
val test_score_challenge_2_24 = score_challenge ([(Hearts,Ace),(Spades,Ace)], 24) = 2;


(* Three Aces *)
val test_score_challenge_3_1 = score_challenge ([(Hearts,Ace),(Spades,Ace),(Hearts,Ace)], 3) = 0;
val test_score_challenge_3_2 = score_challenge ([(Hearts,Ace),(Spades,Ace),(Hearts,Ace)], 13) = 0;
val test_score_challenge_3_3 = score_challenge ([(Hearts,Ace),(Spades,Ace),(Hearts,Ace)], 23) = 0;
val test_score_challenge_3_3 = score_challenge ([(Hearts,Ace),(Spades,Ace),(Hearts,Ace)], 33) = 0;
val test_score_challenge_3_4 = score_challenge ([(Hearts,Ace),(Spades,Ace),(Hearts,Ace)], 38) = 5;
