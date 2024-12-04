extends Node3D

# Variables for angles and speed
var angle1 = 0.0    # Angle for the first pendulum arm
var speed1 = 2.50    # Angular velocity for both arms (shared)
var amplitude1 = 60.0   # Swing amplitude for the first arm
var amplitude2 = -60.0   # Swing amplitude for the second arm

func _physics_process(delta):
	# Update the angle for the first arm
	angle1 += speed1 * delta
	 # Fix Pivot1's position (ensures one end of Arm1 is stationary)
	$Pivot1.global_transform.origin = Vector3(0, 0, 0)  # Fixed at the origin (or your desired position)
	# Calculate the new rotation of the first arm
	$Pivot1.rotation_degrees.z = sin(angle1) * amplitude1

	# Update Pivot2 to follow Bob1
	var bob1_global_position = $Pivot1/Arm1/Bob1.global_transform.origin
	$Pivot1/Arm1/Pivot2.global_transform.origin = bob1_global_position

	# Rotate the second arm smoothly
	$Pivot1/Arm1/Pivot2.rotation_degrees.z = -sin(angle1) * amplitude2
