extends Sprite

var color = Color(255,255,255)
var bright = Color(255,255,255)
var show_bright = false

func set_color(new_color):
	color = new_color
	modulate = color
	
func set_bright(new_color):
	bright = new_color
	
func _process(delta):
	if show_bright:
		modulate = bright
	else: modulate = color