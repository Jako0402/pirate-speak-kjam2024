extends Node

const MAX_HEALTH = 7
var health = 1:
	set(new_value): health = clamp(new_value, 0, MAX_HEALTH)

var _params = {"all_keys": ["key_2-tap",
						"key_3-tap",
						"key_4-tap",
						"key_1-hold",
						"key_2-hold",
						"key_3-hold",
						"key_4-hold",],
				"keys": []}

var captain_speak = ["Arr", "Ahoy", "Fire" ,"Treasure"]
var translate_speak = ["Business", "Tea", "Opportunity", "Literacy"]
var score = 0

func change_scene(next_scene, params={}):
	_params.merge(params, true)
	get_tree().change_scene_to_file(next_scene)


func reset():
	_params = {"all_keys": ["key_2-tap",
						"key_3-tap",
						"key_4-tap",
						"key_1-hold",
						"key_2-hold",
						"key_3-hold",
						"key_4-hold",],
				"keys": []}
	health = 3
	score = 0
	_ready()
		


func get_param(name):
	if _params != null and _params.has(name):
		return _params[name]
	return null

func _ready() -> void:
	_params["all_keys"].shuffle()
	_params["all_keys"].push_front("key_1-tap")
	captain_speak.shuffle()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		reset()
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
