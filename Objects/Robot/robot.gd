extends KinematicBody2D

var drive_dir = 0
var max_speed = 75
var rotation_speed = 3
var velocity = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	
	# drive direction
	if Input.is_action_pressed("ui_up"): drive_dir = -1
	elif Input.is_action_pressed("ui_down"): drive_dir = 1
	else: drive_dir = 0
	
	# rotation
	if Input.is_action_pressed("ui_left"): rotate(0.5 * delta * -1 * rotation_speed)
	elif Input.is_action_pressed("ui_right"): rotate(0.5 * delta * rotation_speed)
	
	#velocity = Vector2(-sin(global_rotation), cos(global_rotation)) * Vector2(delta*drive_dir*max_speed, delta*drive_dir*max_speed)
	velocity = Vector2(-sin(global_rotation), cos(global_rotation)) * Vector2(drive_dir*max_speed, drive_dir*max_speed)
	#position = position + Vector2(-sin(global_rotation), cos(global_rotation)) * Vector2(delta*drive_dir*max_speed, delta*drive_dir*max_speed)
	move_and_slide(velocity)
	

func _input(event):
	pass