extends Node3D

# Define constants and initial state
var g = 9.81  # Gravitational acceleration
var length1 = 2.0  # Length of the first arm
var length2 = 1.5  # Length of the second arm
var mass1 = 1.0  # Mass of the first pendulum bob
var mass2 = 1.0  # Mass of the second pendulum bob
var angle1 = PI / 4  # Initial angle of the first arm
var angle2 = PI / 4  # Initial angle of the second arm
var angular_velocity1 = 0.0  # Initial angular velocity of the first arm
var angular_velocity2 = 0.0  # Initial angular velocity of the second arm

func _ready():
	# Initialization code, set up scene or adjust initial mesh properties if necessary
	pass

func _physics_process(delta):
	# Physics calculations to update angular velocities and angles
	var alpha1 = calculate_angular_acceleration1()
	var alpha2 = calculate_angular_acceleration2()
	angular_velocity1 += alpha1 * delta
	angular_velocity2 += alpha2 * delta
	angle1 += angular_velocity1 * delta
	angle2 += angular_velocity2 * delta

	# Update node transformations
	$FirstArm.rotation_degrees.y = -angle1 * (180 / PI)
	$FirstArm/SecondArm.rotation_degrees.y = -angle2 * (180 / PI)
# Example functions to calculate angular accelerations
func calculate_angular_acceleration1():
	# Placeholder for actual calculation, using dummy values
	return -g / length1 * sin(angle1)

func calculate_angular_acceleration2():
	# Placeholder for actual calculation, using dummy values
	return -g / length2 * sin(angle2)
