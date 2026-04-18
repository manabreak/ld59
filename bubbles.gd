class_name Bubbles
extends Control

var offset: Vector2 = Vector2(0.0, -80.0)
var tween: Tween = null
var show_time_msec: int = 0

func _ready() -> void:
	$PlayerSpeech.modulate.a = 0.0
	print("Minimum size: %s" % $PlayerSpeech.custom_minimum_size)


func show_text(text: String) -> void:
	if tween != null && tween.is_running():
		await tween.finished
	tween = create_tween()
	tween.tween_property($PlayerSpeech, "modulate:a", 1.0, 0.5)
	show_time_msec = Time.get_ticks_msec()
	
	$PlayerSpeech.text = text
	$PlayerSpeech.position = get_viewport_rect().size / 2.0 - $PlayerSpeech.custom_minimum_size / 2.0 + offset
	

func hide_text() -> void:
	if tween != null && tween.is_running():
		await tween.finished
	
	if Time.get_ticks_msec() - show_time_msec < 3000:
		await get_tree().create_timer(float(Time.get_ticks_msec() - show_time_msec) / 100.0).timeout
	
	tween = create_tween()
	tween.tween_property($PlayerSpeech, "modulate:a", 0.0, 0.5)
