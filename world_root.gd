class_name WorldRoot
extends Node2D

@export var main_camera: Camera2D
@export var light_camera: Camera2D
@export var light_manager: LightManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	light_camera.global_position = main_camera.global_position


func add_pulse(pulse: LightPulse) -> void:
	light_manager.add_pulse(pulse)
