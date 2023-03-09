use "cesar_cipher.sml";
use "vigenere_cipher.sml";
use "files.sml";

signature MENU =
sig

    exception invalidChoice

    val menu : 'a -> int
    val menu_cesar : 'a -> unit
    val menu_vigenere : 'a -> unit
    val goodbye : 'a -> unit

end

structure Menus :> MENU =
struct

infix !>
fun x !> f = f x

exception invalidChoice

(*Receives a string and returns it with only lowercase characters.
  
  fn : string -> string*)
val String_toLower = fn str => (map (Char.toLower)  (String.explode str)) !> String.implode

(*Receives a string option with a int value and returns the int.
  
  fn : string option -> int*)
val get_num = fn str => case str of
			    NONE => 0
			  | SOME x => (case Int.fromString x of
					   NONE => 0
					 | SOME y => y)

fun goodbye _ = print "\nThanks For Using The App! =)\n\n"
					  
(* Receives anything and returns the option selected by the user

  fn : 'a -> int*)					  
fun menu _ =
    let
	val _ = print "\n====== Welcome ======\n";
	val _ = print "\n(1) Cesar Cipher\n"
	val _ = print "(2) Vigenere Cipher\n"
	val _ = print "(3) Exit\n"
	val _ = print "\nChoice: "

	val choice = get_num(TextIO.inputLine TextIO.stdIn)

    in if choice <= 0 orelse choice > 3 then raise invalidChoice else choice end

(*Receives nothing and returns nothing. But in the execution of the code get's data from the user, applys the criptography function and shows the user the result.

 fn : 'a -> unit *)
fun menu_cesar _ =
    let
	val _ = print "\n===== Cesar Cypher =====\n\n"
	val _ = print "Mensage: "
	val mensage = String_toLower(valOf(TextIO.inputLine TextIO.stdIn))
    
	val _ = print "Key: "
	val key = get_num (TextIO.inputLine TextIO.stdIn)
	val _ = print "\n(1) Encrypt\n(2) Decript\n\nOperation: "
	val crip_or_descrip = get_num(TextIO.inputLine TextIO.stdIn)
    in
	if crip_or_descrip <= 0 orelse crip_or_descrip > 2
	then raise invalidChoice
	else
	    (let

		val result = Cesar_cipher.cesar(crip_or_descrip, mensage, key, "abcdefghijklmnopqrstuvwxyz");
		val _ = Files.save "results/" result (Int.toString key)
	    in
		(print ("\n***** Result ****\n");
		 print ("\nYour Mensage: " ^ result);
		 print ("\nKey Used: " ^ Int.toString key ^ "\n");
		 goodbye())
	    end)
    end

(*Receives nothing and returns nothing. But in the execution of the code get's data from the user, applys the criptography function and shows/save the result.

 fn : 'a -> unit *)
fun menu_vigenere _ =
    let
	val alphabet = "abcdefghijklmnopqrstuvwxyz"
	val _ = print "\n===== Vigenere Cypher =====\n\n"
	val _ = print "Mensage: "
	val mensage = String_toLower(valOf(TextIO.inputLine TextIO.stdIn))
	val mensage_filtered = Cesar_cipher.cesar(1, mensage, 0, alphabet)
    
	val _ = print "Key: "
	val key = String_toLower(valOf(TextIO.inputLine TextIO.stdIn))
	val key_filtered = Cesar_cipher.cesar(1, key, 0, alphabet)
						 
	val _ = print "\n(1) Encrypt\n(2) Decript\n\nOperation: "
	val crip_or_descrip = get_num(TextIO.inputLine TextIO.stdIn)
				     
	val new_key = Vigenere_cipher.normalize (String.explode key_filtered) (String.size key_filtered)
						0 (String.size mensage_filtered) [] 
    in
	if crip_or_descrip <= 0 orelse crip_or_descrip > 2
	then raise invalidChoice
	else
	    (let
		val result = String.implode(Vigenere_cipher.vigenere(crip_or_descrip,
								   (String.explode mensage_filtered),
								   new_key, []))
		val _ = Files.save "results/" result key_filtered
	    in
		(print ("\n***** Result ****\n");
		 print ("\nYour Mensage: " ^ result);
		 print ("\nKey Used: " ^ key_filtered ^ "\n");
		 goodbye())
	    end)	     
    end
	
end
