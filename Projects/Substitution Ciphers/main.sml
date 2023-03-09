use "menu.sml";

structure Main =
struct

fun main _ =
    let
	val choice = Menus.menu()
    in
	case choice of
	    1 => Menus.menu_cesar()
	  | 2 => Menus.menu_vigenere()
	  | 3 => Menus.goodbye()
	  | _ => print ("Ainda em Construção!\n")
    end
	
end

val _ = Main.main()
