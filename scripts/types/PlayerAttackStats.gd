extends Node2D
class_name PlayerAttackStats

var fire_rate: float = 2.0
var shot_speed: float = 75
var shot_range: float = 2
var shot_damage: float = 1
var shot_spread: float = deg_to_rad(10)
var shot_count: int = 1
var shot_size: float = 4
var is_beam: bool = false

var shot_effects: Array[Effect]
var firing_effecct: Array[Effect]

var bullet: PackedScene = preload("res://entities/projectiles/slug.tscn")
