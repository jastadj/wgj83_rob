extends Area2D

signal player_activate

func _ready():
	connect("player_activate", get_tree().root.get_node("Game/Player"), "player_activated")
	
func player_activated(obj):
	print("player activated bomb")