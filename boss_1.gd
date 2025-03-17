extends Area2D

signal hit

@export var laser: PackedScene
@export var health = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LaserBeamCD.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (health <= 0):
		queue_free()

func _on_laser_beam_cd_timeout() -> void:
	var laser = laser.instantiate()
	
	var laser_location = $Path2D/PathFollow2D
	laser_location.progress_ratio = randf()
	laser.position = laser_location.position
	
	laser.linear_velocity = Vector2(-400, 0)
	
	add_child(laser)

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player_projectiles")):
		health -= 1
		hit.emit()
		body.queue_free()
