extends Node3D

# Variables for angles, speed
@export var angle1: float = 45.0    # Initial angle for the first pendulum arm
@export var angle2: float = -30.0   # Initial angle for the second pendulum arm
@export var speed1: float = 3.5     # Angular velocity for the first arm
@export var speed2: float = 4.2     # Angular velocity for the second arm
@export var amplitude1: float = 50.0  # Swing amplitude for the first arm
@export var amplitude2: float = -40.0 # Swing amplitude for the second arm

# Pause state
var is_paused = false  # Whether the simulation is paused

# Speed increment/decrement step
@export var speed_step: float = 0.5

func _physics_process(delta):
	if is_paused:
		return  # Do nothing if paused

	# Update angles
	angle1 += speed1 * delta
	angle2 += speed2 * delta

	# Update first pendulum rotation
	var pivot1 = $Pivot1
	pivot1.rotation_degrees.z = sin(angle1) * amplitude1

	# Update second pendulum rotation
	var pivot2 = pivot1.get_node("Arm1/Pivot2")
	var bob1_global_position = pivot1.get_node("Arm1/Bob1").global_transform.origin
	pivot2.global_transform.origin = bob1_global_position
	pivot2.rotation_degrees.z = sin(angle2) * amplitude2

	if OS.is_debug_build():
		print_debug("Pivot1 Rotation Degrees: %f" % pivot1.rotation_degrees.z)
		print_debug("Pivot2 Rotation Degrees: %f" % pivot2.rotation_degrees.z)
		print_debug("Bob1 Position: %s" % str(bob1_global_position))

func _input(event):
	# Toggle pause with "pause" action
	if event.is_action_pressed("pause"): 
		is_paused = !is_paused
		print_debug("Simulation paused:", is_paused)
	
	# Increase speed with "up" action
	if event.is_action_pressed("up"):
		speed1 += speed_step
		speed2 += speed_step
		print_debug("Increased speed: speed1=%f, speed2=%f" % [speed1, speed2])
	
	# Decrease speed with "down" action
	if event.is_action_pressed("down"):
		speed1 = max(0.0, speed1 - speed_step)  # Prevent negative speed
		speed2 = max(0.0, speed2 - speed_step)
		print_debug("Decreased speed: speed1=%f, speed2=%f" % [speed1, speed2])
