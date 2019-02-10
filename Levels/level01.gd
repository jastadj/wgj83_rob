extends Node

signal player_activate

func player_activate():
	# check all bombs to see which one the player is in and activate the bomb defusal ui
	for bomb in $Bombs.get_children():
		if bomb.player_in:
			var newbombui = bomb.bomb_defusal_ui.instance()
			$UI.add_child(newbombui)
			newbombui.bomb_source = bomb
	
	