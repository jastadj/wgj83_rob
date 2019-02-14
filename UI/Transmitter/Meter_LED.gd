extends Node2D

var on_color = Color(1,1,1)
var off_color = Color(1,1,1)
var on = false

func _process(delta):
	if on:
		$LED.modulate = on_color
	else:
		$LED.modulate = off_color
