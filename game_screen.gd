extends Node2D

@onready 
var screen_size = get_viewport_rect().size

var dart: PackedScene = preload("res://entities/enemies/dart.tscn")

func _ready() -> void:
	$Timer.timeout.connect(spawn_mob)

func spawn_mob():
	var d = dart.instantiate()
	add_child(d)
	match randi_range(0, 3):
		0:
			d.global_position = Vector2(0,randf_range(screen_size.y,0))
		1:
			d.global_position = Vector2(screen_size.x,randf_range(screen_size.y,0))
		2:
			d.global_position = Vector2(randf_range(screen_size.x,0), 0)
		3:
			d.global_position = Vector2(randf_range(screen_size.x,0), screen_size.y)
