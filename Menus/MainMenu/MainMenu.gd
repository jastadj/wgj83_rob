extends CanvasLayer

var image_fade_speed = 0.3

func _ready():
	$NewGameButton.connect("pressed", self, "new_game")
	$QuitButton.connect("pressed", self, "quit_game")
	fade_title_image()


func fade_title_image():
	
	for step in range(0,5):
		var timer = get_tree().create_timer(image_fade_speed)
		yield(timer, "timeout")
		$TitleImageCover.modulate.a = $TitleImageCover.modulate.a - 0.25

func new_game():
	$ClickSound.play()
	randomize()
	get_tree().change_scene("res://Levels/level01.tscn")
	
func quit_game():
	$ClickSound.play()
	yield($ClickSound, "finished")
	get_tree().quit()