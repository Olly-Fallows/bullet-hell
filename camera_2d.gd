extends Camera2D

@onready
var target: Vector2 = zoom

func _process(delta: float) -> void:
	zoom = zoom.lerp(target, 0.1*delta)
