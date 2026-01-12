extends Sprite2D
class_name MirrorSprite

@export
var mirroring = true

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if mirroring:
		draw_texture(texture,  -(texture.get_size()/2)+Vector2(0,Utils.camera_rect.size.y).rotated(-global_rotation))
		draw_texture(texture,  -(texture.get_size()/2)+Vector2(0,-Utils.camera_rect.size.y).rotated(-global_rotation))
		draw_texture(texture,  -(texture.get_size()/2)+Vector2(Utils.camera_rect.size.x,0).rotated(-global_rotation))
		draw_texture(texture,  -(texture.get_size()/2)+Vector2(-Utils.camera_rect.size.x,0).rotated(-global_rotation))
