extends Node3D

# Defines the physical parameters of the double pendulum
var length1 = 2.0
var length2 = 2.0
var mass1 = 1.0
var mass2 = 1.0
var gravity = 9.8

# Stores the initial angular positions
var angle1 = PI / 4
var angle2 = PI / 4

# Tracks angular velocities of each arm
var angular_velocity1 = 0.0
var angular_velocity2 = 0.0

# Node references for arms and bobs
var first_arm
var second_arm
var first_bob
var second_bob

func _ready():
	# Assigns nodes based on the scene tree structure
	first_arm = $FirstARM
	second_arm = $FirstARM/SecondARM
	first_bob = $FirstARM/ARM/BALL
	second_bob = $FirstARM/SecondARM/ARM/BALL

	# Sets initial positions relative to each arm
	first_arm.position = Vector3.ZERO
	first_bob.position = Vector3(0, -length1, 0)
	second_arm.position = first_bob.position
	second_bob.position = second_arm.position + Vector3(0, -length2, 0)

func _physics_process(delta):
	# Computes angular accelerations using dynamics equations
	var num1 = -gravity * (2 * mass1 + mass2) * sin(angle1)
	var num2 = -mass2 * gravity * sin(angle1 - 2 * angle2)
	var num3 = -2 * sin(angle1 - angle2) * mass2
	var num4 = angular_velocity2 * angular_velocity2 * length2 + angular_velocity1 * angular_velocity1 * length1 * cos(angle1 - angle2)
	var den = length1 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2))
	var angular_acceleration1 = (num1 + num2 + num3 * num4) / den

	num1 = 2 * sin(angle1 - angle2)
	num2 = (angular_velocity1 * angular_velocity1 * length1 * (mass1 + mass2))
	num3 = gravity * (mass1 + mass2) * cos(angle1)
	num4 = angular_velocity2 * angular_velocity2 * length2 * mass2 * cos(angle1 - angle2)
	den = length2 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2))
	var angular_acceleration2 = (num1 * (num2 + num3 + num4)) / den

	# Updates angular velocities and angles based on accelerations
	angular_velocity1 += angular_acceleration1 * delta
	angular_velocity2 += angular_acceleration2 * delta
	angle1 += angular_velocity1 * delta
	angle2 += angular_velocity2 * delta

	# Calculates the new positions of the bobs
	var x1 = length1 * sin(angle1)
	var y1 = -length1 * cos(angle1)
	var x2 = x1 + length2 * sin(angle2)
	var y2 = y1 - length2 * cos(angle2)

	# Rotates the arms according to the new angles
	first_arm.rotation_degrees = Vector3(0, 0, -rad_to_deg(angle1))
	second_arm.rotation_degrees = Vector3(0, 0, -rad_to_deg(angle2))

	# Moves the bobs to the computed positions
	first_bob.position = Vector3(x1, y1, 0)
	second_bob.position = Vector3(x2, y2, 0)
