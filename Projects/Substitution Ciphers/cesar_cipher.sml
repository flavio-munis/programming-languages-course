signature CESAR =
sig

    val !> : 'a * ('a -> 'b) -> 'b
    val cesar : (int * string * int * string) -> string
    val filter : ('a -> 'b option) -> 'a list -> 'b list
    val crip_descrip : int -> char list -> char -> char option
    val get_index : (char list * char) -> int
			 
end
    
structure Cesar_cipher :> CESAR =

struct

(*High-Order function that organizes the order of calls of functions and it's arguments

  fn : 'a * ('a -> 'b) -> 'b*)
infix !>
fun x !> f = f x

(*Receives a filter function and a list, returns an list with only the filtered elements

  fn : ('a -> 'b option) -> 'a list -> 'b list*)
fun filter f =
    (fn s =>
	case s of
	    [] => []
	  | x::xs => case (f x) of
			 NONE => filter f xs
		       | SOME l => l :: filter f xs
    )

(*Returns the index of a letter in the alphabet.

  fn : int -> char list -> char -> char option*)
fun get_index (alphabet_list : char list, l) =
    case alphabet_list of
	[] => ~1
      | x :: xs => if x = l
		   then 0
		   else 1 + get_index (xs, l)

(*Executes the trade of the orginal/encrypted letter, to the encrypted/original letter and returns it.

  fn : int -> char list -> char -> char option*)
fun crip_descrip key alphabet letter =
	let					  
	    val letter_lowercase = Char.toLower letter
	    val get_element = (fn i => List.nth (alphabet, (key + i) mod 26))							    
	in
	    if Char.contains (String.implode alphabet) letter_lowercase
	    then SOME(get_element (get_index(alphabet, letter_lowercase)))
	    else NONE
	end

(*Transform the value of the key in an valid value and returns it.

  fn : int -> int*)
val normalize = fn key => (if key > 26 
			   then key mod 26
			   else
			       if key < 0
			       then (key mod 26) + 26
			       else key)

(*Cheks if the user is encrypting or decrypting a mensage, modifies the key accordanly and returns it

  fn : (int * int) -> int*)
val crip_descrip_key = fn (key, crip_or_descrip) =>
			 if crip_or_descrip = 1
			 then normalize key
			 else normalize key * ~1
					  
(*Organizes the information, calls the criptography function and returns the encrypted/Decrypted mensage.

  fn : (int * string * int * string) -> string*)
fun cesar(crip_or_descrip, mensage, key, alphabet) =
    let
	val key_normalizer = crip_descrip_key (key, crip_or_descrip)
	val fun_crip_descrip = crip_descrip key_normalizer
	val alphabet_list = String.explode alphabet
	val result = filter (fn letter => fun_crip_descrip alphabet_list letter) (String.explode mensage)
    in
	String.implode result
    end

end
