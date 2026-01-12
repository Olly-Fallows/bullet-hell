extends Node2D


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
