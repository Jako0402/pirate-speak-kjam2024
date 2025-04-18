extends Node2D

@onready var instruction: Label = $Instruction
@onready var previous: Label = $Previous

var level
var seq_length
var keys
var all_keys

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = GameManager.get_param("level")
	seq_length = GameManager.get_param("seq_length")
	keys = GameManager.get_param("keys")
	all_keys = GameManager.get_param("all_keys")
	var new_instruction_text = ""
	var previous_text = ""
	
	# TODO LOGIC HERE TO CHOOSE NEXT LEVEL
	if level < 9:
		keys.append(all_keys[level])
		new_instruction_text = generate_display_string(level)
		
		level += 1
	else:
		seq_length += 1
		new_instruction_text = "MOARRR TEXT"	
	instruction.text = new_instruction_text
	GameManager.score += 1
	
	
	for i in range(level - 1):
		previous_text += generate_display_string(i)
		previous_text += "\n"
	previous.text = previous_text
	
	
	await get_tree().create_timer(3).timeout
	GameManager.change_scene("res://scenes/game.tscn", {"seq_length":seq_length, 
														"keys": keys,
														"level": level})

func generate_display_string(index):
	var before = GameManager.captain_speak[int(all_keys[index]) - 1]
	var before_hold = ""
	var after_hold = ""
	if "hold" in all_keys[index]:
		before_hold = "!"
		after_hold = " hold"
	var after = GameManager.translate_speak[int(all_keys[index]) - 1]
	return before + before_hold + " --> " + after + after_hold
