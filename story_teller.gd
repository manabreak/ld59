class_name StoryTeller
extends Node2D

@export var enable_storytelling: bool = true
@export var player: Player
@export var world_root: WorldRoot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enable_storytelling:
		return
	
	player.allow_signals = false
	player.input_enabled = false
	world_root.show_bubble("Well, 'ello.")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("I'm Shiny McShinebottom.")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("A connoisseur of fine arts.")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("I... seem to have misplaced myself.")
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(2.0).timeout
	world_root.show_bubble("I can't really see much...")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("But I seem to get signals when I tap my feet like this.")
	await get_tree().create_timer(2.0).timeout
	player.create_step_pulse()
	await get_tree().create_timer(2.0).timeout
	player.create_step_pulse()
	await get_tree().create_timer(0.5).timeout
	player.create_step_pulse()
	await get_tree().create_timer(2.5).timeout
	world_root.show_bubble("And I guess I'll make the signals greater if I jump.")
	await get_tree().create_timer(3.0).timeout
	# player.create_land_pulse()
	player.jump()
	await get_tree().create_timer(2.0).timeout
	world_root.show_bubble("Whoa.")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("Welp, that seems to help at least a bit.")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("I wonder how I get out of here...")
	await get_tree().create_timer(4.0).timeout
	
	world_root.hide_bubble()
	player.input_enabled = true
	player.allow_signals = true
	
