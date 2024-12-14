extends SpringArm3D

# Fixed position for the spring arm
var fixed_position: Vector3 = Vector3(0, 0, 0)

func _ready():
	# Ensure the SpringArm3D is at the fixed position when the scene starts
	global_transform.origin = fixed_position

func _process(delta):
	# Keep the SpringArm3D fixed at the specified position
	global_transform.origin = fixed_position

	# Ensure Arm1 follows the SpringArm3D's position
	if has_node("Arm1"):
		var arm1 = get_node("Arm1")
		arm1.global_transform.origin = global_transform.origin
