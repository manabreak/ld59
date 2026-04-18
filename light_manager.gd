class_name LightManager
extends Node2D

@export var player_light: Node2D
var pulses: Array[LightPulse] = []

func add_pulse(pulse: LightPulse) -> void:
	add_child(pulse)


func player_position_changed(position: Vector2) -> void:
	player_light.global_position = position


func add_global_light(sprite: Sprite2D) -> void:
	print("Add global light at %s" % sprite.global_position)
	sprite.visible = true
	add_child(sprite)
