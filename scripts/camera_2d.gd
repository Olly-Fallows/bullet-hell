extends Camera2D

@onready
var target: Vector2 = zoom

func _ready() -> void:
	SignalBus.level_changed.connect(func(level: int):
		target = Vector2(max(3-float(level)/10, 1), max(3-float(level)/10, 1)))

func _process(delta: float) -> void:
	zoom = zoom.lerp(target, 0.1*delta)
