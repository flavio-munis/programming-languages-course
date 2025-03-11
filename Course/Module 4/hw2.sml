(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string (s1 : string, s2 : string) =
    s1 = s2


(* Problem 1*)
(* all_except_option - Remove a string from a string list, if string is not in list return NONE, else returns SOME of the string list without the string.
 *
 * Return Type:
 * fn : string : string list -> string list option*)
fun all_except_option (s, s_list) =
	case s_list of
		[] => NONE
	  | s1::s1' => if same_string (s1, s)
				   then SOME s1'
				   else 
					   let
						   val res = all_except_option (s, s1')
					   in
						   case res of
							   NONE => NONE
							 | SOME lst => SOME (s1::lst)
					   end

(* get_substitutions1 - Takes a string list list which describes substituions, and a string s. Return all list that has s as a element, without s as part of the final list.
 *
 * Return Type:
 * fn : string list list, string -> string list*)
fun get_substitutions1 (s_list, s) =
	case s_list of
		[] => []
	  | xs::xs' => 
		let
			val res = all_except_option (s, xs)
		in
			case res of
				NONE => get_substitutions1(xs', s)
			  | SOME ys => ys@get_substitutions1(xs', s) 
		end  


(* get_substitutions2 - Same as get_substitutions1 but uses a tail recursive approach.
 *
 * Return Type:
 * fn : string list list, string -> string list*)
fun get_substitutions2 (s_list, s) =
	let
		fun aux (s_list, acc) =
			case s_list of
				[] => acc
			  | xs::xs' => 
				let
					val res = all_except_option (s, xs)
				in
					case res of
						NONE => aux(xs', acc)
					  | SOME ys => aux(xs', acc@ys) 
				end  
	in
		aux (s_list, [])
	end


(* similar_names - Takes a string list list and a record with {first, middle, last} name, returns all possibles substituion of first with the corresponding string list element.
 *
 * Return Type:
 * fn : string list list, {first=string, middle=string, end=string} -> {first=string, middle=string, end=string} list*)
fun similar_names (s_list, {first=f, middle=m, last=l}) =
	let
		val names = f::get_substitutions2(s_list, f)

		fun aux [] = []
		  | aux (x::xs') = {first=x,middle=m,last=l}::(aux xs')
	in
		aux names
	end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* Problem 2*)
(* card_color - Returns the color of a given card. (Spades/Clubs - Black, Hearts/Diamonds - Red).
 *
 * Return Type:
 * fn : card -> color*)
fun card_color (Clubs, _) = Black
  | card_color (Spades, _) = Black
  | card_color _ = Red


(* card_value - Returns the value of a given card. (Num i -> i, Ace -> 11, _ -> 10).
 *
 * Return Type:
 * fn : card -> int*)
fun card_value (_, Ace) = 11
  | card_value (_, Num i) = i
  | card_value _ = 10


(* remove_card - Takes a list of cards, a card and a exception, remove the first instance of the card found and return the list, if card not in list raise an exception.
 *
 * Return Type:
 * fn : card list, card, exn -> card list*)
fun remove_card ([], _, exn) = raise exn
  | remove_card (x::xs', card, exn) = if x = card then xs' else x::remove_card(xs', card, exn)


(* all_same_color - Takes a list of cards, and returns if all cards are the same color.
 *
 * Return Type:
 * fn : card list -> bool*)
fun all_same_color card_list =
	case card_list of
		[] => true
	  | _::[] => true
	  | x::(y::xs') => if card_color x = card_color y
					   then all_same_color (y::xs')
					   else false


(* sum_cards - Takes a list of cards and sums the values of it's cards.
 *
 * Return Type:
 * fn : card list -> int*)
fun sum_cards card_list =
	let 
		fun aux (card_list, acc) =
			case card_list of
				[] => acc
			  | c::xs' => aux (xs', acc+ (card_value c))
	in
		aux (card_list, 0)
	end


(* score - Takes a list of cards and a goal and computes the score of the game.
 *
 * Return Type:
 * fn : card list, int -> int*)
fun score (card_list, goal) =
	let
		val sum = sum_cards card_list
		val preliminary_score = if sum > goal
								then 3*(sum-goal)
								else goal-sum
	in
		if all_same_color card_list
		then preliminary_score div 2
		else preliminary_score
	end


(* officiate - Takes a list of cards, a move list, and a goal. Return the score after the game is processed the moves in order.
 *
 * Return Type:
 * fn : card list, move list, int -> int*)
fun officiate (card_list, move_list, goal) =
	let
		fun run_game (card_list, move_list, held_cards) =
			case move_list of
				[] => score (held_cards, goal)
			  | m::ms' => 
				case m of
					Draw => (
					case card_list of
						[] => score (held_cards, goal)
					  | c::cs' => if sum_cards (c::held_cards) > goal
								  then score (c::held_cards, goal)
								  else run_game (cs', ms',c::held_cards))
					| Discard c => run_game(card_list,
											ms',
											remove_card (card_list, c, IllegalMove))
	in
		run_game (card_list, move_list, [])
	end


(* 3. Challenge Problems *)
(* score_challenge - Computes the best score where aces can be 1 or 11.
 * Proof of Correctude:
 Given a card list with n aces in it, each ace can have a indepentend value of 1 or 11, which results in a binary decision tree with 2^n results of summing the cards.
 Given a goal, there are two ways to calculate the score, either score > goal, let's call it res_1, or score <= goal, let's call it res_2.

** res_1 = 3*(sum - goal) / res_2 = goal - sum

Given a collection with all the possible results, let's call it S = [s_1, s_2, ..., s_n]. Let's split this collection into to where,

** s_res_1 = s_k | s_k > goal, k ∈ {1,2,...,n}
** s_res_2 = s_k | s_k <= goal, k ∈ {1,2,...,n}

The best result for a res_1 score is if sum - goal = 1, which results in, 3*(sum-goal) >= 3.
For a res_2 result, if goal = sum, so, goal - sum = 0, which results in a perfect score.

So, for finding the optimal result we must find the max element in both collections (s_res_1 and s_res_2), so the best possible score is min(max(s_res_1), max(s_res_2)).
 *
 * fn : card list, int -> int*)
fun score_challenge (card_list, goal) =
	let
		(* sum_not_aces - Sum all the cards that aren't aces and return it's sum and the number of aces in the list.
		 *
		 * Return Type:
		 * fn : card list, int * int -> int * int *)
		fun sum_not_aces (card_list, ans) = 
			case card_list of
				[] => ans
			  | c::cs' => 
				case ans of
					(sum, aces) =>
						 case c of
							 (_, Ace) => sum_not_aces (cs', (sum, aces + 1))
						   | (_, Num i) => sum_not_aces (cs', (sum + i, aces)) 
						   | _ =>  sum_not_aces (cs', (sum + 10, aces))

		fun min_score (sum_aux) =
			let
				val prev_res = (goal - sum_aux) mod 10
			in
				if prev_res > 7
				then 3*((sum_aux - goal) mod 10)
				else prev_res
			end
			

		fun best_score (sum, aces) =
			if sum >= goal orelse sum + aces > goal
			then 3*((sum + aces) - goal)
			else 
				if sum + aces = goal
				then 0
				else
					if goal > sum + 11*aces
					then goal - (sum + 11*aces)
					else min_score (sum + aces)
		
		val score = best_score (sum_not_aces (card_list, (0,0)))
	in
		if all_same_color card_list
		then score div 2
		else score
	end
