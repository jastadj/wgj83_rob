extends Panel

func _ready():
	$ContinueButton.connect("pressed", self, "do_continue")
	$QuitButton.connect("pressed", self, "do_quit")
	hide()
	
func toggle():
	if is_visible_in_tree(): close_menu()
	else: open_menu()

func open_menu():
	get_tree().root.get_node("Game/UI/Timer").freeze = true
	show()
	
func close_menu():
	get_tree().root.get_node("Game/UI/Timer").freeze = false
	hide()

func do_continue():
	$ButtonClick.play()
	close_menu()
	
func do_quit():
	$ButtonClick.play()
	close_menu()
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
