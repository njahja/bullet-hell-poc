extends Area2D

signal hit

@export var Bullet: PackedScene

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	$WeaponCD.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D):
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	$InvulTimer.start()


func _on_invul_timer_timeout():
	$CollisionShape2D.set_deferred("disabled", false)


func _on_weapon_cd_timeout() -> void:
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.transform = $Marker2D.global_transform
