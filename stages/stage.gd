extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerHP.text = "Player HP: " + str($Player.health)
	$BossHP.text = "Boss HP: " + str($Boss1.health)

func _on_player_hit() -> void:
	$PlayerHP.text = "Player HP: " + str($Player.health)

func _on_boss_1_hit() -> void:
	$BossHP.text = "Boss HP: " + str($Boss1.health)
