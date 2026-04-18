class_name LightPulse
extends Node2D

@export var burst_light_energy: float = 1.0
@export var reveal_light_energy: float = 1.0

@export var burst_range: float = 1.0
@export var reveal_range: float = 1.0

@export var burst_time: float = 1.0
@export var reveal_time: float = 1.0

@export var burst_decay_time: float = 1.0
@export var reveal_decay_time: float = 1.0

@export var oneshot: bool = true

var tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sweep()


func stop_sweep() -> void:
	if tween != null:
		tween.stop()


func sweep() -> void:
	$Burst.scale = Vector2.ZERO
	$Reveal.scale = Vector2.ZERO
	$Burst.modulate.a = burst_light_energy
	$Reveal.modulate.a = reveal_light_energy
	
	var tween = create_tween()
	tween.tween_property($Burst, "scale", Vector2(burst_range, burst_range), burst_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.parallel()
	tween.tween_property($Reveal, "scale", Vector2(reveal_range, reveal_range), reveal_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.parallel()
	tween.tween_property($Burst, "modulate:a", 0.0, burst_decay_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.parallel()
	tween.tween_property($Reveal, "modulate:a", 0.0, reveal_decay_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	
	await tween.finished
	
	if !is_queued_for_deletion():
		queue_free()
