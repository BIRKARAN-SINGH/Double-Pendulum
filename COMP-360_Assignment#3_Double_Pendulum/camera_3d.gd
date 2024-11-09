extends Camera3D

func _process(delta):
	# Target position to focus the camera on (e.g., end of SecondArm)
	var target_position = get_node("../../PivotPoint/FirstArm/SecondArm").global_transform.origin

	# Make the camera look at the target position
	look_at(target_position, Vector3.UP)

	# Optional: Adjust camera position or zoom dynamically if desired
