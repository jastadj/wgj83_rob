extends Node

signal player_activate
var level_failed = false
var level_passed = false
var next_level = null

func player_activate():
	# check all bombs to see which one the player is in and activate the bomb defusal ui
	for bomb in $Bombs.get_children():
		if bomb.player_in && bomb.armed && bomb.found:
			var newbombui = bomb.bomb_defusal_ui.instance()
			$UI.add_child(newbombui)
			newbombui.bomb_source = bomb

func _process(delta):
	
	if level_failed or level_passed:
		$CanvasLayer/Panel.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# if failed level, fade to black and exit to main menu
	if level_failed: return
	
	# update signal strength to closest bomb
	var closest_bomb = get_nearest_bomb()
	# valid armed
	if closest_bomb:
		var closest_bomb_distance = closest_bomb.position.distance_to($Robot.position)
		var sig_str = 100 - (closest_bomb_distance / $Robot.sensor_range)
		if sig_str >= 86:
			closest_bomb.found = true
		#print(sig_str)
		$UI/TransmitterUI.signal_strength(sig_str)
	# no valid bombs found, zero out signal strength
	else:
		$UI/TransmitterUI.signal_strength(0)
		
		if get_armed_bomb_count() == 0:
			$UI/Timer.freeze = true
			if not level_passed:
				success()
	
	# if ran out of time, fail
	if $UI/Timer.timer_in_seconds == 0 && not level_failed:
		failed()

func get_armed_bomb_count():
	var count = 0
	for bomb in $Bombs.get_children():
		if bomb.armed:
			count += 1
	return count

func success():
	level_passed = true
	
	# disable player movement
	$Robot.disable_movement = true
	
	# play fade animation
	var timer1 = get_tree().create_timer(1)
	yield(timer1, "timeout")
	$CanvasLayer/Panel/AnimationPlayer.play("fadetoblack")
	yield($CanvasLayer/Panel/AnimationPlayer, "animation_finished")
	var timer2 = get_tree().create_timer(1)
	yield(timer2, "timeout")	
	$CanvasLayer/success_label.show()
	var timer3 = get_tree().create_timer(2)
	yield(timer3, "timeout")
	# switch to next level is applicable
	if next_level:
		get_tree().change_scene(next_level)
	else:
		get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$UI/GameMenu.toggle()

func failed():
	level_failed = true
	
	# disable player movement
	$Robot.disable_movement = true
	
	# play death animation
	$CanvasLayer/Panel/AnimationPlayer.play("white")
	$CanvasLayer/fail_label.show()
	#yield($CanvasLayer/Panel/AnimationPlayer, "animation_finished")
	$FailSound.play()
	yield($FailSound, "finished")
	
	
	var timer1 = get_tree().create_timer(1)
	yield(timer1, "timeout")
	$CanvasLayer/Panel/AnimationPlayer.play("whitetoblack")
	
	yield($CanvasLayer/Panel/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
	
		
func get_nearest_bomb():
	
	var closest_bomb = null
	var closest_distance = 0
	
	# find closest bomb
	for bomb in $Bombs.get_children():
		var distance_to_player = $Robot.position.distance_to(bomb.position)
		# 
		if not closest_bomb && bomb.armed and not bomb.found:
			closest_bomb = bomb
			closest_distance = distance_to_player
			continue
		else:
			if distance_to_player < closest_distance and bomb.armed and not bomb.found:
				closest_bomb = bomb
				closest_distance = distance_to_player
	
	# return closest bomb
	return closest_bomb
		
		
	
	