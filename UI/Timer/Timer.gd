extends Control

const CRUNCH_TIME = 10
const BLINK_SPEED = 0.15
export(int) var timer_in_seconds = 0
var _delta_accumulator = 0
var blink_timer = null

func _ready():
	display_time(0)	

func _process(delta):
	
	# collect delta times between process, if over 1 second, decrement timer and
	# set new delta accumulator
	_delta_accumulator += delta	
	if _delta_accumulator >= 1.0:
		var sec = int(_delta_accumulator)
		timer_in_seconds -= sec
		_delta_accumulator -= sec

	# if timer is negative, set to 0
	if timer_in_seconds < 0: timer_in_seconds = 0
	
	# update ui
	display_time(timer_in_seconds)

func display_time(time_s):
	var minutes = time_s / 60
	var seconds = time_s - (minutes*60)
	
	# minutes
	$mxxx.val = minutes / 10
	$xmxx.val = minutes % 10
	
	# seconds
	$xxsx.val = seconds / 10
	$xxxs.val = seconds % 10
	
	# if timer is at or below CRUNCH_TIME, blink
	if timer_in_seconds <= CRUNCH_TIME:
		if not blink_timer:
			blink_timer = get_tree().create_timer(BLINK_SPEED * 2)
		
		if blink_timer:
			if blink_timer.get_time_left() <= BLINK_SPEED:
				hide()
			else:
				show()
		if blink_timer.get_time_left() <= 0:
			blink_timer = null
