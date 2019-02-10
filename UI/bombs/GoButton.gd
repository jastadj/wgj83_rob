extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	toggle_mode = true

func _toggled(button_pressed):
	disabled = true
	get_parent().go_button_toggled()
	
