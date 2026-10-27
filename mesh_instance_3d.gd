extends MeshInstance3D

func _process(delta):
	# This smoothly rotates the hologram on its Y (vertical) axis every frame
	rotate_y(1.5 * delta)
