extends Node2D

@onready var health_bar: Node2D = $HealthBar
@onready var label: Label = $Label
@onready var level: Label = $level
var answers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	answers = GameManager.get_param("answers")
	var num_wrong = answers.count(false)
	
	if num_wrong == 0:
		GameManager.health += 1
		health_bar.update_health(1)
	else:
		GameManager.health -= num_wrong - 1
		health_bar.update_health(-(num_wrong-1))
		
	
	level.text = "Level: " + str(GameManager.get_param("level"))
	label.text = "Your score:" + str(answers.count(true)) +  "/" + str(answers.size())
 
	await get_tree().create_timer(5).timeout
	
	if GameManager.health == 0:
		GameManager.change_scene("res://scenes/game_over.tscn")
		return
	GameManager.change_scene("res://scenes/instructions.tscn", {"answers":answers})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
