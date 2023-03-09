use "cesar_cipher.sml";

signature VIGENERE =
sig

    val normalize : char list -> int -> int -> int -> char list -> char list
    val vigenere : (int * char list * char list * char list) -> char list
    
end

structure Vigenere_cipher :> VIGENERE =
struct

(*Receives a key and it's lenght, the lenght of the new key and the length of the mensage. Returns the key with his proper form for this cipher

 fn : char list -> int -> int -> int -> char list -> char list*)
fun normalize key key_length new_key_length mensage_length new_key =
       
       if mensage_length = new_key_length
       then new_key
       else
	   let
	       val key_index = new_key_length mod key_length
	   in
	        normalize key key_length (new_key_length + 1) mensage_length (new_key @ [List.nth(key, key_index)])
	   end

(*Rceives it's a encrip or encript operation, a message and a key. Returns the message with the vigenere cipher applied to it.

  fn : (int * char list * char list * char list) -> char list*)
fun vigenere (crip_or_descrip, mensage, key, mensage_crip) =    
    case (crip_or_descrip, mensage, key) of
	(_, [], []) => mensage_crip
      | (_, x::xs, y::ys) => (
	  let
	      val alphabet_exploded = String.explode ("abcdefghijklmnopqrstuvwxyz")
	      val index_mensage = Cesar_cipher.get_index(alphabet_exploded, x)
	      val index_key = Cesar_cipher.get_index(alphabet_exploded, y)
							
	  in
	      if crip_or_descrip = 1
	      then vigenere(crip_or_descrip, xs, ys, mensage_crip @ [List.nth (alphabet_exploded, ((index_mensage + index_key) mod 26))])
	      else vigenere(crip_or_descrip, xs, ys, mensage_crip @ [List.nth (alphabet_exploded, ((index_mensage - index_key + 26) mod 26))])
	  end)
      | _ => []
end
