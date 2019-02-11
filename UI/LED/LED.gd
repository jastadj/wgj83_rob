extends Node2D

var val = 0

func _process(delta):
	if val < 0: val = 0
	elif val > 9: val = 9
	$Sprite.frame = val

