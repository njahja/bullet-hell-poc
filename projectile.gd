extends RigidBody2D

@export var speed = 800

func _ready():
	linear_velocity = Vector2(speed, 0)
