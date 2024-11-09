extends Node3D

# Configuration parameters
@export_group("Pendulum Properties")
@export var rod_length_1: float = 1.0
@export var rod_length_2: float = 1.0
@export var mass_1: float = 1.0
@export var mass_2: float = 1.0
@export var gravity: float = 9.81
@export var damping: float = 0.999

@export_group("Initial Conditions")
@export var initial_angle_1: float = PI / 4  # 45 degrees
@export var initial_angle_2: float = PI / 4
@export var initial_velocity_1: float = 0.0
@export var initial_velocity_2: float = 0.0

@export_group("Debug")
@export var debug_mode: bool = true
@export var pause_simulation: bool = false

# State variables
var theta1: float      # Angle of first pendulum
var theta2: float      # Angle of second pendulum
var omega1: float      # Angular velocity of first pendulum
var omega2: float      # Angular velocity of second pendulum

# Node references - adjust according to your actual node structure
@onready var arm1 = $Pivot/FirstArm
@onready var arm2 = $Pivot/FirstArm/SecondArm

func _ready():
	if debug_mode:
		print("Starting pendulum simulation...")

	# Initialize the pendulum state
	theta1 = initial_angle_1
	theta2 = initial_angle_2
	omega1 = initial_velocity_1
	omega2 = initial_velocity_2

	# Initial position update
	update_positions()

func _physics_process(delta):
	if pause_simulation:
		return

	calculate_physics(delta)
	update_positions()

	if debug_mode:
		print("Physics Frame: ", Engine.get_physics_frames())

func calculate_physics(delta):
	var g = gravity
	var m1 = mass_1
	var m2 = mass_2
	var l1 = rod_length_1
	var l2 = rod_length_2

	# Precompute terms used in the formulas
	var sin_t1 = sin(theta1)
	var sin_t2 = sin(theta2)
	var cos_diff = cos(theta1 - theta2)

	# Angular acceleration calculations
	var num1 = -g * (2 * m1 + m2) * sin_t1 - m2 * g * sin(theta1 - 2 * theta2)
	num1 -= 2 * sin(theta1 - theta2) * m2 * (omega2 ** 2 * l2 + omega1 ** 2 * l1 * cos_diff)
	var den1 = l1 * (2 * m1 + m2 - m2 * cos(2 * (theta1 - theta2)))
	var alpha1 = num1 / den1

	var num2 = 2 * sin(theta1 - theta2) * (omega1 ** 2 * l1 * (m1 + m2) + g * (m1 + m2) * cos(theta1) + omega2 ** 2 * l2 * m2 * cos_diff)
	var den2 = l2 * (2 * m1 + m2 - m2 * cos(2 * (theta1 - theta2)))
	var alpha2 = num2 / den2

	# Update velocities and angles
	omega1 += alpha1 * delta
	omega2 += alpha2 * delta
	omega1 *= damping
	omega2 *= damping
	theta1 += omega1 * delta
	theta2 += omega2 * delta

func update_positions():
	arm1.rotation_degrees.z = theta1 * (180 / PI)
	arm1/arm2.rotation_degrees.z = (theta2 - theta1) * (180 / PI)
