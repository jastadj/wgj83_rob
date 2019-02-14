extends Area2D

signal player_activate
var player_in = false
var bomb_defusal_ui = preload("res://UI/bombs/bomb2ui.tscn")
var armed = true
var found = false

func _ready():
	connect("body_entered", self, "object_entered")
	connect("body_exited", self, "object_exited")

func _process(delta):
	if found:
		$Sprite.show()
		if not armed:
			$Sprite.modulate.a = 0.4
	else:
		$Sprite.hide()

func object_entered(obj):
	if obj.filename == "res://Objects/Robot/robot.tscn":
		player_in = true

func object_exited(obj):
	if obj.filename == "res://Objects/Robot/robot.tscn":
		player_in = false