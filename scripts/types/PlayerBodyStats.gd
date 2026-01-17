extends Node2D
class_name PlayerBodyStats

signal dead

var max_health: float = 4
@onready
var health: float = max_health
var size: float = 1
var speed: float = 75
var turn_speed: float = 4
var acceloration: float = 1.5

func _ready() -> void:
	$Hurtbox.hurt.connect(hurt)

func hurt(box: Hitbox):
	Utils.screen_freeze(0.5)
	health -= box.damage
	SignalBus.health_changed.emit(health, max_health)
	if health <= 0:
		dead.emit()
	
