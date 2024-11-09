extends Camera3D

func _process(delta):
	var target = get_node("../PivotPoint/FirstArm/SecondArm").global_transform.origin
	look_at(target, Vector3.UP)  # Keep the camera looking at the end of the second arm
