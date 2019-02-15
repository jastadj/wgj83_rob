extends "res://Levels/level_base.gd"

func _ready():
	# set the next level
	set_level_time(60*4)
	next_level = "res://Levels/level03.tscn"
