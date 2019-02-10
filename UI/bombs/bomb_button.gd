extends Control

var color = Color(255,255,255)
var bright = Color(255,255,255)
var show_bright = false
var button_down = false

signal pressed

func _ready():
	$TextureButton.connect("button_down", self, "button_pressed")
	$TextureButton.connect("button_up", self, "button_released")

func set_color(new_color):
	color = new_color
	$TextureButton.modulate = color

func set_bright(new_color):
	bright = new_color
	
func _process(delta):
	if show_bright or button_down:
		$TextureButton.modulate = bright
	else: $TextureButton.modulate = color

func button_pressed():
	if get_parent().get_parent().state != "ready": return
	$ClickInSound.play()
	button_down = true
	
	
func button_released():
	if get_parent().get_parent().state != "ready": return
	#$ClickOutSound.play()
	button_down = false
	get_parent().get_parent().enter_sequence(self)