extends Area2D

signal player_activate
var player_in = false
var bomb_defusal_ui = preload("res://UI/bombs/bomb1ui.tscn")
var armed = true

func _ready():
	connect("body_entered", self, "object_entered")
	connect("body_exited", self, "object_exited")
		
func object_entered(obj):
	if obj.filename == "res://Objects/Robot/robot.tscn":
		player_in = true
		
func object_exited(obj):
	if obj.filename == "res://Objects/Robot/robot.tscn":
		player_in = false