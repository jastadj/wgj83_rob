extends KinematicBody2D

var drive_dir = 0
var max_speed = 75
var acceleration = 150
var deceleration = 0.80
var rotation_speed = 3
var velocity = Vector2(0,0)
var disable_movement = false
signal player_activate
var drive_sound_state = 0
const DRIVE_VOLUME = -15

var sensor_range = 6

func _ready():
	# adjust drive volume
	$DriveStopSound.volume_db = DRIVE_VOLUME
	$DriveSound.volume_db = DRIVE_VOLUME
	$DriveStartSound.volume_db = DRIVE_VOLUME

func _process(delta):
	pass

func _physics_process(delta):
	
	# drive direction as long as movement isn't disable
	if not disable_movement:
		if Input.is_action_pressed("ui_up"): drive_dir = -1
		elif Input.is_action_pressed("ui_down"): drive_dir = 1
		else: drive_dir = 0
	
		# rotation
		if Input.is_action_pressed("ui_left"): rotate(0.5 * delta * -1 * rotation_speed)
		elif Input.is_action_pressed("ui_right"): rotate(0.5 * delta * rotation_speed)
	else:
		drive_dir = 0
	
	# drive sound state
	# if not moving
	if drive_dir == 0:
		# but sound state thinks it is, play stop sound, kill drive sound
		if drive_sound_state == 2:
			$DriveSound.stop()
			$DriveStopSound.play()
			drive_sound_state = 3
		# if drive stop sound is done
		elif drive_sound_state == 3:
			if not $DriveSound.playing:
				drive_sound_state = 0
		elif drive_sound_state == 1:
			$DriveStartSound.stop()
			drive_sound_state = 0
	# if moving
	else:
		# if sound state is stopped, play drive start sound
		if drive_sound_state == 0:
			drive_sound_state = 1
			$DriveStartSound.play()
		elif drive_sound_state == 1:
			if not $DriveStartSound.playing:
				drive_sound_state = 2
				$DriveSound.play()
			
			
	
	# if accelerating
	if drive_dir != 0:
		velocity = velocity + ( Vector2(-sin(global_rotation), cos(global_rotation)) * Vector2(drive_dir*acceleration*delta, drive_dir*acceleration*delta) )
		if velocity.length() > max_speed:
			velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.clamped(velocity.length()*deceleration)

	#print("drive_dir:" + str(drive_dir) + "  vel:" + str(velocity.length()))
	
	# set tread speed and move robot in direction its rotated at its current speed
	$LeftTread.current_speed = velocity.length() * drive_dir * 4
	$RightTread.current_speed = velocity.length() * drive_dir * 4
	move_and_slide(velocity)
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("action pressed")
		get_parent().player_activate()
		