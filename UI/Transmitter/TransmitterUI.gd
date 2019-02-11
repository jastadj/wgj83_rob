extends Control

var led_scene = preload("res://UI/Transmitter/Meter_LED.tscn")
const OFF_COLOR = 0.25
var leds = []

func _ready():
	# create LED array
	for i in range(0,10):
		var newled = led_scene.instance()
		$LEDs.add_child(newled)
		newled.position = Vector2(32, 14 + (i*11) )
		leds.push_back(newled)		
		
		# set LED colors
		if i >= 0 and i <= 3:
			leds[i].on_color = Color(0,1,0)
			leds[i].off_color = Color(0,OFF_COLOR,0)
		elif i >=4 and i <=6:
			leds[i].on_color = Color(1,1,0)
			leds[i].off_color = Color(OFF_COLOR,OFF_COLOR,0)
		else:
			leds[i].on_color = Color(1,0,0)
			leds[i].off_color = Color(OFF_COLOR,0,0)

func signal_strength(percent):
	
	if percent < 0: percent = 0
	elif percent > 100: percent = 100
	
	# determine first LED index to start lighting
	var meter_index = floor( (100 - percent) / 10)
	
	# turn on/off LEDs depending on strength
	for i in range(0,10):
		if i >= meter_index:
			leds[i].on = true
		else:
			leds[i].on = false