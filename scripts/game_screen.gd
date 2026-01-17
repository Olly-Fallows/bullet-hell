extends Node2D

var dart: PackedScene = preload("res://entities/enemies/Dart.tscn")
var small_astroid: PackedScene = preload("res://entities/enemies/SmallAstroid.tscn")

func _ready() -> void:
	$Timer.timeout.connect(func():
		spawn_mob(dart))

func spawn_mob(mob: PackedScene):
	var d = mob.instantiate()
	add_child(d)
	match randi_range(0, 3):
		0:
			d.global_position = Vector2(Utils.camera_rect.position.x-32,randf_range(Utils.camera_rect.end.y,Utils.camera_rect.position.y))
		1:
			d.global_position = Vector2(Utils.camera_rect.end.x+32,randf_range(Utils.camera_rect.end.y,Utils.camera_rect.position.y))
		2:
			d.global_position = Vector2(randf_range(Utils.camera_rect.end.x,Utils.camera_rect.position.x), Utils.camera_rect.position.y-32)
		3:
			d.global_position = Vector2(randf_range(Utils.camera_rect.end.x,Utils.camera_rect.position.x), Utils.camera_rect.end.y+32)
