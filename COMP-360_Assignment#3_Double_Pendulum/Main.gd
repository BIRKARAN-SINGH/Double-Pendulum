extends Node3D

func _ready():
	print("Simulation initialized.")
	# Additional initialization as needed

func start_simulation():
	get_node("PivotPoint").start_simulation()

func stop_simulation():
	get_node("PivotPoint").stop_simulation()
