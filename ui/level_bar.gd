extends ProgressBar

func _ready() -> void:
	SignalBus.xp_changed.connect(update_bar)

func update_bar(xp: int, xp_needed: int) -> void:
	max_value = xp_needed
	value = xp
