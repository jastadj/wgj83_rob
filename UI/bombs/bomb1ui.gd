extends Control

var colors = []
var colors_bright = []
var sequence = []
var state = "none"
var sequence_speed = 0.3
var sequence_entered = []
var bomb_source = null
var solved_sound = "res://Sounds/246332__kwahmah-02__five-beeps.wav"

func _ready():
	
	# initialize colors
	colors.push_back(Color(0.5,0,0) )
	colors.push_back(Color(0,0.5,0) )
	colors.push_back(Color(0,0,0.5) )
	colors.push_back(Color(0.5,0.5,0) )

	colors_bright.push_back(Color(1,0,0) )
	colors_bright.push_back(Color(0,1,0) )
	colors_bright.push_back(Color(0,0,1) )
	colors_bright.push_back(Color(1,1,0) )	
	
	
	# randomize colors
	var button_colors = colors.duplicate()
	var button_bright = colors_bright.duplicate()
	var wire_colors = colors.duplicate()
	var wire_bright = colors_bright.duplicate()
	
	for cbutton in $ColorButtons.get_children():
		var color_index = randi()%button_colors.size()
		cbutton.set_color( button_colors[color_index])
		cbutton.set_bright( button_bright[color_index])
		button_colors.remove(color_index)
		button_bright.remove(color_index)
		
	for cwire in $Wires.get_children():
		var color_index = randi()%wire_colors.size()
		cwire.set_color( wire_colors[color_index])
		cwire.set_bright( wire_bright[color_index])
		wire_colors.remove(color_index)
		wire_bright.remove(color_index)
		
	# create sequence
	var sequence_indices = []
	for i in range(0, $Wires.get_child_count()):
		sequence_indices.push_back(i)
	for i in range(0, $Wires.get_child_count()):
		var sindex = randi()%sequence_indices.size() 
		sequence.push_back(sequence_indices[sindex])
		sequence_indices.remove(sindex)
	
func _enter_tree():
	# when bomb ui comes into play, disable player movement
	get_tree().root.get_node("Game/Robot").disable_movement = true	

func _exit_tree():
	# when bomb defusal UI exits tree, allow movement again
	if not bomb_source.armed:
		get_tree().root.get_node("Game/Robot").disable_movement = false	
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		queue_free()
		
func go_button_toggled():
	$GoButtonSound.play()
	show_sequence()
	
func show_sequence():
	state = "show_sequence"
	
	# little delay
	var timer_start = get_tree().create_timer(0.5)
	yield(timer_start, "timeout")
	
	for i in range(0, sequence.size()):
		var timer1 = get_tree().create_timer(sequence_speed)
		$ColorButtons.get_child(sequence[i]).show_bright = true
		yield(timer1, "timeout")
		timer1 = get_tree().create_timer(sequence_speed)
		yield(timer1, "timeout")
		$ColorButtons.get_child(sequence[i]).show_bright = false
	state = "ready"

func enter_sequence(obj):
	if state != "ready": return
	
	# determine if sequence is correct
	for i in range(0, $ColorButtons.get_children().size()):
		if $ColorButtons.get_child(i) == obj:
			sequence_entered.push_back(i)
			# if entered wrong sequence
			if sequence[sequence_entered.size()-1] != i:
				get_tree().quit()
	
	# if completed sequences
	if sequence.size() == sequence_entered.size():
		state = "success"
		bomb_source.armed = false
		$Success_Sound.play()
		yield($Success_Sound, "finished")
		var timer2 = get_tree().create_timer(0.25)
		yield(timer2, "timeout")
		queue_free()