extends Area2D

signal hit

@export var Bullet: PackedScene
@export var health = 10
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
	
	if (health <= 0):
		queue_free()

func _on_body_entered(body: Node2D):
	if (body.is_in_group("enemy_projectiles")):
		$CollisionShape2D.set_deferred("disabled", true)
		$InvulTimer.start()

		$FlashHitTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("flash_modifier", 0.5)
		
		health -= 1
		hit.emit()
		body.queue_free()

func _on_invul_timer_timeout():
	$CollisionShape2D.set_deferred("disabled", false)

func _on_weapon_cd_timeout():
	var bullet = Bullet.instantiate()
	bullet.position = position
	owner.add_child(bullet)


func _on_flash_hit_timer_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("flash_modifier", 0)
