extends Node3D

# Constants
var g: float = 9.81  # Acceleration due to gravity
var length1: float = 2.0  # Length of the first pendulum arm
var length2: float = 1.5  # Length of the second pendulum arm
var mass1: float = 1.0  # Mass of the first pendulum bob
var mass2: float = 1.0  # Mass of the second pendulum bob

# Initial angles (in radians)
var angle1: float = PI / 4  # 45 degrees
var angle2: float = PI / 6  # 30 degrees
var angle1_velocity: float = 0.0
var angle2_velocity: float = 0.0

# Node references
onready var first_arm = $FirstARM
onready var second_arm = $FirstARM/SecondARM
onready var first_bob = $FirstARM/BALL
onready var second_bob = $FirstARM/SecondARM/BALL

func _ready():
	# Verify that all nodes are assigned correctly
	if first_arm == null or second_arm == null or first_bob == null or second_bob == null:
		print("Error: One or more nodes are not assigned correctly.")
		return

	# Initialize positions
	update_pendulum_positions()


func _physics_process(delta):
	# Calculate angular accelerations
	var num1 = -g * (2 * mass1 + mass2) * sin(angle1)
	var num2 = -mass2 * g * sin(angle1 - 2 * angle2)
	var num3 = -2 * sin(angle1 - angle2) * mass2
	var num4 = angle2_velocity ** 2 * length2 + angle1_velocity ** 2 * length1 * cos(angle1 - angle2)
	var denominator = length1 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2))
	var angle1_acceleration = (num1 + num2 + num3 * num4) / denominator

	num1 = 2 * sin(angle1 - angle2)
	num2 = angle1_velocity ** 2 * length1 * (mass1 + mass2)
	num3 = g * (mass1 + mass2) * cos(angle1)
	num4 = angle2_velocity ** 2 * length2 * mass2 * cos(angle1 - angle2)
	denominator = length2 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2))
	var angle2_acceleration = (num1 * (num2 + num3 + num4)) / denominator

	# Update velocities and angles
	angle1_velocity += angle1_acceleration * delta
	angle2_velocity += angle2_acceleration * delta
	angle1 += angle1_velocity * delta
	angle2 += angle2_velocity * delta

	# Update positions
	update_pendulum_positions()

func update_pendulum_positions():
	# Position of the first bob
	var x1 = length1 * sin(angle1)
	var y1 = -length1 * cos(angle1)
	first_bob.global_transform.origin = first_arm.global_transform.origin + Vector3(x1, y1, 0)

	# Position of the second bob
	var x2 = x1 + length2 * sin(angle2)
	var y2 = y1 - length2 * cos(angle2)
	second_bob.global_transform.origin = first_bob.global_transform.origin + Vector3(x2 - x1, y2 - y1, 0)

	# Update arm rotations
	first_arm.rotation_degrees.z = angle1 * (180 / PI)
	second_arm.rotation_degrees.z = (angle2 - angle1) * (180 / PI)
