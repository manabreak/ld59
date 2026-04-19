extends Node2D


func play_music() -> void:
	$Intro.play()
	await $Intro.finished
	$Loop.play()


func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property($Loop, "volume_linear", 0.0, 4.0)
