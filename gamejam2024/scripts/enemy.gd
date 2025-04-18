extends Node2D

var key_sequence = []
var action_sequence = []
var is_correct_answer = []
var seq_pointer = 0
var seq_wait = 0.5
 
signal timer_begin
signal seq_complete(answers)

@onready var seq_label: Label = $Seq_label
@onready var feedback_label: Label = $FeedbackLabel
@onready var bar_timer: Node2D = $BarTimer
@onready var speach_bubble: Sprite2D = $SpeachBubble

@onready var arr: AudioStreamPlayer2D = $"../Audio/Captain/Arr"
@onready var ahoy: AudioStreamPlayer2D = $"../Audio/Captain/Ahoy"
@onready var fire: AudioStreamPlayer2D = $"../Audio/Captain/Fire"
@onready var treasure: AudioStreamPlayer2D = $"../Audio/Captain/Treasure"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_next_input(key, action):
	if seq_pointer >= key_sequence.size():
		return
	if key == key_sequence[seq_pointer] and action == action_sequence[seq_pointer]:
		feedback_label.text = "Correct"
		is_correct_answer.append(true)
	else:
		feedback_label.text = "Wrong"
		is_correct_answer.append(false)
	seq_pointer += 1
	if (seq_pointer >= key_sequence.size()):
		seq_complete.emit(is_correct_answer)
		bar_timer.queue_free()
	await get_tree().create_timer(0.2).timeout
	feedback_label.text = "..."
	# display_sequence()

func display_sequence():
	var display_string = ""
	for i in range(key_sequence.size()):
		if (i == seq_pointer):
			display_string += GameManager.captain_speak[int(key_sequence[i]) - 1].to_upper() 
		else: 
			display_string += GameManager.captain_speak[int(key_sequence[i]) - 1]
		
		if action_sequence[i] == "hold":
			display_string += "!"
		
		print(key_sequence[i] + " " + action_sequence[i])
		
		if (i < seq_pointer):
			if (is_correct_answer[i] ):
				display_string += "   O "
			else:
				display_string += "   X "
		
		display_string += "\n"
		
	seq_label.text = display_string

func start_level():
	generate_sequence()



func generate_sequence():
	# TODO: FIX MIG
	key_sequence.clear()
	action_sequence.clear()
	is_correct_answer.clear()
	seq_pointer = 0
	
	var keys = GameManager.get_param("keys")
	var seq_length = GameManager.get_param("seq_length")
	
	for i in range(seq_length):
		var key = keys.pick_random().split("-")
		key_sequence.push_back(key[0])
		action_sequence.push_back(key[1])
		# display_sequence()
		
		var seq_label_text = GameManager.captain_speak[int(key_sequence[i]) - 1]
		if key[1] == "hold":
			seq_label_text += "!"
		seq_label.text = seq_label_text
		# print(GameManager.captain_speak[int(key[0]) - 1])
		play_captain_audio(GameManager.captain_speak[int(key[0]) - 1])
		await get_tree().create_timer(0.5).timeout
		seq_label.text = "..."
		await get_tree().create_timer(seq_wait).timeout
		
	# display_sequence()
	seq_label.text = ""
	bar_timer.start_timer()
	speach_bubble.visible = true
	timer_begin.emit()


func play_captain_audio(captain_word):
	if captain_word == "Arr":
		arr.play()
	elif captain_word == "Ahoy":
		ahoy.play()
	elif captain_word == "Fire":
		fire.play()
	elif captain_word == "Treasure":
		treasure.play()
	



func _on_bar_timer_timeout() -> void:
	for i in range(seq_pointer, key_sequence.size()):
		print("wrong missed answer")
		is_correct_answer.append(false)
	seq_complete.emit(is_correct_answer)
	seq_pointer = key_sequence.size()
	bar_timer.queue_free()
