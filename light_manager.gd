class_name LightManager
extends Node2D

var pulses: Array[LightPulse] = []

func add_pulse(pulse: LightPulse) -> void:
	add_child(pulse)
	print("Light pulses now: %d" % get_child_count())
