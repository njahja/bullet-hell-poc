extends Area2D

@export var laser: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LaserBeamCD.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_laser_beam_cd_timeout() -> void:
	var laser = laser.instantiate()
	
	var laser_location = $Path2D/PathFollow2D
	laser_location.progress_ratio = randf()
	laser.position = laser_location.position
	
	laser.linear_velocity = Vector2(-400, 0)
	
	add_child(laser)
