extends Area2D

var value: int = 1

func _ready() -> void:
	body_entered.connect(func(body: RigidBody2D):
		if body is Player:
			LevelTracker.gain_xp(value)
			queue_free())
