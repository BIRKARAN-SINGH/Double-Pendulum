**Double Pendulum Simulation in Godot**

**Introduction**
This project involves creating a 3D simulation of a double pendulum system using the Godot engine. The simulation aims to demonstrate the dynamic and programmatic movements of a double pendulum modeled in a 3D space, utilizing real-time physics updates.

**Project Objective**
To develop a realistic simulation of a double pendulum with hierarchical object modeling.
Implement the _physics_process method to ensure smooth updates at 60 frames per second.
Utilize basic physics principles to model the pendulum's motion realistically.
Development Process
Scene Configuration
The main scene is set up with hierarchical structures that include pendulum arms and a supportive environment. The script is attached to the main node to manage physics calculations and animations.

Video Demonstration: https://drive.google.com/file/d/1pUSSBSiDNIOKm8eNce4lcPGjL_GXeJSn/view 

**Table of Contents**
1. Project Setup
2. Running the Simulation
3. Scripting
4. Testing and Calibration 
5. Contributions


**Project Setup** 
*Prerequisites*
Godot Engine 4.x: Install from Godot's official website.

*Cloning the Repository*
To set up the project locally:

1.Clone the repository:
git clone https://github.com/BIRKARAN-SINGH/Double-Pendulum.git

2. Open the project in Godot:
-Launch Godot Engine.
-Open the cloned folder as a project.

3.Installing Dependencies
No external dependencies are required for this project.

*Running the Simulation*
1. Open the main.tscn scene in Godot.
2. Press the play button (F5) to run the simulation.
3. The simulation will show the two pendulum arms swinging in a 3D space.

*Controls*
Use the mouse to adjust the camera view and observe the motion of the pendulum.

**Scripting**
A single script is attached to the main node, which encapsulates all the logic required for the simulation:

extends Node3D

# Physical and kinematic properties of the double pendulum
var length1 = 2.0
var length2 = 2.0
var mass1 = 1.0
var mass2 = 1.0
var gravity = 9.8

# Initial angular positions and velocities
var angle1 = PI / 4
var angle2 = PI / 4
var angular_velocity1 = 0.0
var angular_velocity2 = 0.0

# Node references for arms and bobs
var first_arm
var second_arm
var first_bob
var second_bob

func _ready():
    # Initialize node paths from the scene hierarchy
    first_arm = $FirstARM
    second_arm = $FirstARM/SecondARM
    first_bob = $FirstARM/ARM/BALL
    second_bob = $FirstARM/SecondARM/ARM/BALL

    # Set initial positions
    first_arm.position = Vector3.ZERO
    first_bob.position = Vector3(0, -length1, 0)
    second_arm.position = first_bob.position
    second_bob.position = second_arm.position + Vector3(0, -length2, 0)

func _physics_process(delta):
    # Dynamics calculations for pendulum motion
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

    # Update positions based on dynamics
    angular_velocity1 += angular_acceleration1 * delta
    angular_velocity2 += angular_acceleration2 * delta
    angle1 += angular_velocity1 * delta
    angle2 += angular_velocity2 * delta

    # Adjust arm and bob rotations and positions
    first_arm.rotation_degrees = Vector3(0, 0, -rad_to_deg(angle1))
    second_arm.rotation_degrees = Vector3(0, 0, -rad_to_deg(angle2))
    first_bob.position = Vector3(x1, y1, 0)
    second_bob.position = Vector3(x2, y2, 0)
Testing and Calibration
Motion Testing: Ensures that transitions are smooth and the pendulum movements are realistic.
Hierarchy Testing: Confirms correct motion inheritance between arms and checks the stability of the system.
Physics Parameter Tuning: Calibrates gravity, damping, and angular velocities to find the optimal settings for simulation realism.
Conclusion
This project not only provides an understanding of 3D animation and simulation but also showcases how theoretical physics can be practically applied in digital environments. The real-time simulation aspect emphasizes the capabilities of the Godot engine in handling complex physics calculations and rendering them smoothly.

Contributions
Birkaran Singh: Led the development and implementation of the simulation, focusing on the physics calculations and system dynamics.
Fuzail Chaugle: Led the documentation aspect of the project, Contributed to enhancing visual aspects and camera dynamics to improve the overall aesthetic and functionality of the simulation.


