extends RigidBody2D
class_name Wrapping

@export
var wrapping: bool = false

func do_wrapping():
	if wrapping:
		global_position.x = wrapf(global_position.x, Utils.camera_rect.position.x, Utils.camera_rect.end.x)
		global_position.y = wrapf(global_position.y, Utils.camera_rect.position.y, Utils.camera_rect.end.y)
	else:
		if global_position.x < Utils.camera_rect.end.x-32:
			if global_position.y < Utils.camera_rect.end.y-32:
				if global_position.x > Utils.camera_rect.position.x+32:
					if global_position.y > Utils.camera_rect.position.y+32:
						wrapping = true
						for c in get_children():
							if c is MirrorSprite:
								c.mirroring = true
