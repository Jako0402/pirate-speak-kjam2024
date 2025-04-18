extends Control

@onready var score: Label = $Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "You score was: " + str(GameManager.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	GameManager.reset()
	GameManager.change_scene("res://scenes/instructions.tscn", {"level": 0, "seq_length":3})


func _on_back_pressed() -> void:
	GameManager.reset()
	GameManager.change_scene("res://scenes/main_menu.tscn")
