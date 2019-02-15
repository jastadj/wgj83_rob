extends "res://Levels/level_base.gd"

func _ready():
	# set the next level
	set_level_time(60*3)
	next_level = "res://Levels/level05.tscn"
