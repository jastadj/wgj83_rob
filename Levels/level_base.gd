extends Node

signal player_activate
var failed = false

func player_activate():
	# check all bombs to see which one the player is in and activate the bomb defusal ui
	for bomb in $Bombs.get_children():
		if bomb.player_in && bomb.armed:
			var newbombui = bomb.bomb_defusal_ui.instance()
			$UI.add_child(newbombui)
			newbombui.bomb_source = bomb

func _process(delta):
	# if failed level, fade to black and exit to main menu
	if failed:
		if not $CanvasLayer/Panel/AnimationPlayer.is_playing():
			get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")

func failed():
	$CanvasLayer/Panel/AnimationPlayer.play("white")
	$FailSound.play()
	yield($FailSound, "finished")
	var timer1 = get_tree().create_timer(1)
	yield(timer1, "timeout")
	failed = true
	$CanvasLayer/Panel/AnimationPlayer.play("fadetoblack")
		
		
		
		
	
	