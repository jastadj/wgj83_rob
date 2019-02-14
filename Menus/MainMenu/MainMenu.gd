extends CanvasLayer

func _ready():
	$NewGameButton.connect("pressed", self, "new_game")
	$QuitButton.connect("pressed", self, "quit_game")

func new_game():
	$ClickSound.play()
	randomize()
	get_tree().change_scene("res://Levels/level_test.tscn")
	
func quit_game():
	$ClickSound.play()
	yield($ClickSound, "finished")
	get_tree().quit()