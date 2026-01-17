extends Node2D

var xp: int = 0
var level: int = 0

func gain_xp(amount: int) -> void:
	xp += amount
	check_levelup()
	
func check_levelup() -> void:
	if xp >= xp_needed():
		xp -= xp_needed()
		level += 1
		SignalBus.level_changed.emit(level)
		Utils.spawn_levelup(get_tree().get_first_node_in_group("player").global_position)
		return check_levelup()
	SignalBus.xp_changed.emit(xp, xp_needed())

func xp_needed() -> int:
	return (level*level* 5) + 5
