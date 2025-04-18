extends Node2D

var key_held_time = 0.0
var key_pressed = false
const HOLD_THRESHOLD = 0.2
const INPUT_KEYS := ["key_1", "key_2", "key_3", "key_4"]
var read_for_input = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy: Node2D = $Enemy
@onready var bubble: Sprite2D = $bubble

@onready var business: AudioStreamPlayer2D = $Audio/Player/Business
@onready var tea: AudioStreamPlayer2D = $Audio/Player/Tea
@onready var opportunity: AudioStreamPlayer2D = $Audio/Player/Opportunity
@onready var literacy: AudioStreamPlayer2D = $Audio/Player/Literacy


func _ready() -> void:
	enemy.start_level()

func _process(delta) -> void:
	if read_for_input:
		check_keys(delta)

func check_keys(delta) -> void: 
	for k in INPUT_KEYS:	
		if Input.is_action_pressed(k):  
			if not key_pressed:
				key_pressed = true
				key_held_time = 0.0 
			else:
				key_held_time += delta  
				if key_held_time >= HOLD_THRESHOLD:
					animated_sprite_2d.play("key_held")

		if Input.is_action_just_released(k):  
			play_player_sound(int(k))
			if key_held_time >= HOLD_THRESHOLD:
				# print("Key held: " + k)
				enemy.check_next_input(k, "hold")
			else:
				# print("Key tapped: " + k)
				enemy.check_next_input(k, "tap")
			
			key_held_time = 0.0  
			key_pressed = false 


func play_player_sound(index):
	if index == 1:
		business.play()
		animated_sprite_2d.play("business")
	elif index == 2:
		tea.play()
		animated_sprite_2d.play("tea")
	elif index == 3:
		opportunity.play()
		animated_sprite_2d.play("opportunity")
	elif index == 4:
		literacy.play()
		animated_sprite_2d.play("literacy")
	


func _on_enemy_timer_begin() -> void:
	read_for_input = true
	bubble.queue_free()
	


func _on_enemy_seq_complete(answers) -> void:
	print(answers)
	await get_tree().create_timer(1).timeout
	GameManager.change_scene("res://scenes/count_score.tscn", {"answers":answers})


func _on_animated_sprite_2d_animation_looped() -> void:
	if not animated_sprite_2d.animation == "key_held":
		animated_sprite_2d.play("default")
