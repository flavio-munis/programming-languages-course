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
