extends Sprite2D

@onready 
var screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_texture(texture,  -texture.get_size()/2+Vector2(0,screen_size.y).rotated(-global_rotation))
	draw_texture(texture,  -texture.get_size()/2+Vector2(0,-screen_size.y).rotated(-global_rotation))
	draw_texture(texture,  -texture.get_size()/2+Vector2(screen_size.x,0).rotated(-global_rotation))
	draw_texture(texture,  -texture.get_size()/2+Vector2(-screen_size.x,0).rotated(-global_rotation))
