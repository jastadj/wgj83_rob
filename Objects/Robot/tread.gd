extends Sprite

var current_speed = 0
var speed_scale = 0.05

func _ready():
	pass

func _process(delta):
	
	# change animation when speed direction changes
	if current_speed > 0:
		if $AnimationPlayer.current_animation != "forward" or not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("forward")
	elif current_speed < 0:
		if $AnimationPlayer.current_animation != "backward" or not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("backward")
	else:
		$AnimationPlayer.stop()
	
	# adjust animation playerback speed based on tread speed
	$AnimationPlayer.playback_speed = current_speed * speed_scale

