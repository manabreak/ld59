class_name LightManager
extends Node2D

@export var player_light: Node2D
var pulses: Array[LightPulse] = []

func add_pulse(pulse: LightPulse) -> void:
	add_child(pulse)
	print("Light pulses now: %d" % get_child_count())


func player_position_changed(position: Vector2) -> void:
	player_light.global_position = position
