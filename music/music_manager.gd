extends Node2D


func play_music() -> void:
	$Intro.play()
	await $Intro.finished
	$Loop.play()
