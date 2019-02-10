extends KinematicBody2D

var drive_dir = 0
var max_speed = 75
var acceleration = 150
var deceleration = 0.80
var rotation_speed = 3
var velocity = Vector2(0,0)
signal player_activate

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
	
	# if accelerating
	if drive_dir != 0:
		velocity = velocity + ( Vector2(-sin(global_rotation), cos(global_rotation)) * Vector2(drive_dir*acceleration*delta, drive_dir*acceleration*delta) )
		if velocity.length() > max_speed:
			velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.clamped(velocity.length()*deceleration)

	#print("drive_dir:" + str(drive_dir) + "  vel:" + str(velocity.length()))
	
	# set tread speed and move robot in direction its rotated at its current speed
	$LeftTread.current_speed = velocity.length() * drive_dir
	$RightTread.current_speed = velocity.length() * drive_dir
	move_and_slide(velocity)
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("action pressed")
		emit_signal("player_activate")
		