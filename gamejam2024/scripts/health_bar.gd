extends Node2D

@onready var pb: ProgressBar = $ProgressBar
@onready var marker: Sprite2D = $Bar/Marker
var start_health
const MIN_X = -23
const MAX_X = 17;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_health = GameManager.health
	marker.position.x = remap(start_health, 0, GameManager.MAX_HEALTH, MIN_X, MAX_X)
	pb.value = GameManager.health

func update_health(health_change):
	for i in range(abs(health_change)):
		start_health += health_change / abs(health_change)
		start_health = clamp(start_health, 0, GameManager.MAX_HEALTH)
		await get_tree().create_timer(0.5).timeout
		marker.position.x = remap(start_health, 0, GameManager.MAX_HEALTH, MIN_X, MAX_X)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
