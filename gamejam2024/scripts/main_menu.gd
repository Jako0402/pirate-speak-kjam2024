extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	GameManager.change_scene("res://scenes/instructions.tscn", {"level": 0, "seq_length":3})


func _on_credits_pressed() -> void:
	GameManager.change_scene("res://scenes/credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
