(*Save the current mesage and the key used to encrypt it in a file.

  fn : string -> string -> string -> unit*)
structure Files =
struct

fun save path mensage key =
    let
	val actual_time = Time.toSeconds (Time.now())
	val file = TextIO.openOut (path ^ (LargeInt.toString (actual_time)) ^ ".txt")
    in
	
	TextIO.output (file, (mensage ^ "\n\n" ^ "Key Used: " ^ key));
	TextIO.closeOut file
	
    end
	
end
