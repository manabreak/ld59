class_name StoryTeller
extends Node2D

@export var enable_storytelling: bool = true
@export var player: Player
@export var world_root: WorldRoot


func tell_note(note: NoteArea) -> void:
	player.input_enabled = false
	for text in note.texts:
		world_root.show_bubble(text)
	player.input_enabled = true


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_final"):
		final_animation()


func final_animation() -> void:
	player.input_enabled = false
	
	player.show_fade()
	
	var tilemap = world_root.get_node("TileMapLayer") as TileMapLayer
	var tween = create_tween()
	tween.tween_property(tilemap, "modulate:a", 0.0, 5.0)
	await tween.finished
	
	world_root.show_bubble("...ooookay...")
	world_root.show_bubble("Now what?")
	MusicManager.fade_out()
	await get_tree().create_timer(5.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	
	## 60 seconds of delays
	## 156 seconds of text
	## Total -> 216 seconds of ending. Phew.
	world_root.show_bubble("Is that it?")
	world_root.show_bubble("Seriously.", 3.0, 1.0)
	world_root.show_bubble("All that trouble just to get stuck in a limbo?", 4.0)
	world_root.show_bubble("I hate this.", 3.0, 2.0)
	world_root.show_bubble("SO. MUCH.", 3.0, 1.0)
	world_root.show_bubble("I mean...", 3.0, 2.0)
	world_root.show_bubble("In the time it took to come up with this ending...", 4.0)
	world_root.show_bubble("...you couldn't come up with anything better?", 4.0)
	world_root.show_bubble("That's just lazy.")
	world_root.show_bubble("...and stupid.", 3.0, 2.0)
	world_root.show_bubble("Lazy and stupid.", 3.0, 3.0)
	world_root.show_bubble("*sigh*", 2.0, 3.0)
	world_root.show_bubble("Well, I hope you at least had some fun.", 4.0, 2.0)
	world_root.show_bubble("Maybe you got a bit distracted from all the crap going on?", 4.0)
	world_root.show_bubble("A tiny sliver of silly nonsense?")
	world_root.show_bubble("A chuckle, perhaps?", 3.0, 1.0)
	world_root.show_bubble("A snort?", 3.0, 1.0)
	world_root.show_bubble("A fart?", 3.0, 2.0)
	world_root.show_bubble("I could really use a laugh right now.", 4.0, 2.0)
	world_root.show_bubble("You know...", 3.0, 3.0)
	world_root.show_bubble("You did stick around until the end, after all.", 4.0)
	world_root.show_bubble("That says more about you than it does about me.", 4.0, 2.0)
	world_root.show_bubble("[ERROR: ENDING_NOT_FOUND]", 3.0, 2.0)
	world_root.show_bubble("Oh good, even the ending is buggy.", 4.0)
	world_root.show_bubble("Anyway.", 3.0, 2.0)
	world_root.show_bubble("Goodbye, I guess.")
	world_root.show_bubble("...unless this loops.")
	world_root.show_bubble("Okay, something important is about to happen.", 4.0, 2.0)
	world_root.show_bubble("...nope.", 3.0, 2.0)
	world_root.show_bubble("We can just... stay here a bit longer.", 4.0, 2.0)
	world_root.show_bubble("No rush. I'm sure the void can wait.")
	world_root.show_bubble("No rush. No rush at all...", 4.0)
	world_root.show_bubble("You know these pauses are just to pad runtime, right?", 4.0, 3.0)
	world_root.show_bubble("I'm being a bit dramatic, aren't I?", 4.0, 3.0)
	world_root.show_bubble("I stand by it.", 3.0, 1.0)
	world_root.show_bubble("...hey.", 3.0, 3.0)
	world_root.show_bubble("Thanks for staying.")
	world_root.show_bubble("Even if it was a bad decision.")
	world_root.show_bubble("And thanks for playing.")
	world_root.show_bubble("It means a lot to me.")
	world_root.show_bubble("Seriously.")
	world_root.show_bubble("Oh no, here it comes...", 3.0, 3.0)
	world_root.show_bubble("Any second now...", 3.0, 2.0)
	world_root.show_bubble("Hold on to your butts...", 3.0, 2.0)
	world_root.show_bubble("I HATE THIS SO MUCH!", 8.0, 6.0)


# Called when the node enters the scene tree for the first time.
func start_intro() -> void:
	if !enable_storytelling:
		MusicManager.play_music()
		player.allow_signals = true
		player.input_enabled = true
		return
	
	player.allow_signals = false
	player.input_enabled = false
	world_root.show_bubble("Well, 'ello.")
	await get_tree().create_timer(3.0).timeout
	world_root.show_bubble("I'm Shiny McShinebottom.")
	await get_tree().create_timer(3.0).timeout
	world_root.show_bubble("A connoisseur of fine arts.")
	await get_tree().create_timer(3.0).timeout
	world_root.show_bubble("I... seem to have misplaced myself.")
	player.allow_signals = true
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	world_root.show_bubble("I can't really see much...")
	await get_tree().create_timer(3.0).timeout
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
	
	MusicManager.play_music()
	player.input_enabled = true
	player.allow_signals = true
	
