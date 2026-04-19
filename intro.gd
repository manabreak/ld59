extends Control

@export var play_button: Button
@export var fade: ColorRect

var play_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(self.on_play_pressed)
	fade_in()


func on_play_pressed() -> void:
	if play_pressed:
		return
	$VBoxContainer/PlayButton/ClickSound.play()
	play_pressed = true
	await fade_out()
	get_tree().change_scene_to_file("res://root.tscn")


func fade_in() -> void:
	fade.visible = true
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, 2.0)
	await tween.finished
	


func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 2.0)
	await tween.finished
