class_name Bubbles
extends Control

var offset: Vector2 = Vector2(0.0, -154.0)
var message_queue: Array[BubbleEntry] = []
var processing = false

class BubbleEntry:
	var text: String = ""
	var time: float = 3.0

func _ready() -> void:
	$PlayerSpeech.modulate.a = 0.0


func start_showing_text() -> void:
	while message_queue.size() > 0:
		var message = message_queue.pop_front()
		$PlayerSpeech.text = message.text
		$PlayerSpeech.position = get_viewport_rect().size / 2.0 - $PlayerSpeech.custom_minimum_size / 2.0 + offset
		
		var tween = create_tween()
		tween.tween_property($PlayerSpeech, "modulate:a", 1.0, 0.25)
		tween.tween_property($PlayerSpeech, "modulate:a", 0.0, 0.25).set_delay(message.time)
		await tween.finished
	processing = false


func show_text(text: String, time: float = 3.0) -> void:
	var queue_empty = message_queue.is_empty()
	var entry = BubbleEntry.new()
	entry.text = text
	entry.time = time
	message_queue.append(entry)
	if !processing:
		processing = true
		start_showing_text()


func hide_text() -> void:
	pass
