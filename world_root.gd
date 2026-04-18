class_name WorldRoot
extends Node2D

@export var main_camera: Camera2D
@export var light_camera: Camera2D
@export var light_manager: LightManager


func _process(delta: float) -> void:
	light_camera.global_position = main_camera.global_position
	light_manager.player_position_changed($Player.global_position)


func add_pulse(pulse: LightPulse) -> void:
	light_manager.add_pulse(pulse)
