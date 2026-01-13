extends Node2D

var death_explosion: PackedScene = preload("res://effects/DeathExplosion.tscn")
var xp: PackedScene = preload("res://entities/drops/xp.tscn")

@onready 
var _screen_size = get_viewport_rect().size
@onready 
var _camera = get_viewport().get_camera_2d()
var camera_rect: Rect2i = Rect2i()

func _ready() -> void:
	_update_camera_rect()

func _process(_delta: float) -> void:
	_update_camera_rect()

func _update_camera_rect() -> void:
	_camera.get_screen_center_position()
	camera_rect = Rect2i(_camera.get_screen_center_position()-(_screen_size/_camera.zoom)/2, _screen_size/_camera.zoom)

func spawn_explosion(pos: Vector2):
	var e = death_explosion.instantiate()
	get_tree().current_scene.add_child(e)
	e.global_position = pos

func spawn_xp(pos: Vector2, value: int):
	var e = xp.instantiate()
	get_tree().current_scene.add_child(e)
	e.value = value
	e.global_position = pos

func screen_freeze(time: float, s: float = 0.25) -> void:
	Engine.time_scale = s
	get_tree().create_timer(time, false, false, true).timeout.connect(func():
		Engine.time_scale = 1)
