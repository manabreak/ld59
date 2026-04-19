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
	await get_tree().create_timer(5.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(true)
	await get_tree().create_timer(1.0).timeout
	player.set_flipped(false)
	await get_tree().create_timer(1.0).timeout
	
	world_root.show_bubble("Is that it?")
	world_root.show_bubble("Seriously.")
	world_root.show_bubble("All that trouble just to get stuck in a limbo?")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("I hate this.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("SO. MUCH.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("I mean...")
	world_root.show_bubble("In the time it took to come up with this ending...", 4.0)
	world_root.show_bubble("...you couldn't come up with anything better?", 4.0)
	world_root.show_bubble("That's just lazy.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("...and stupid.")
	await get_tree().create_timer(10.0).timeout
	world_root.show_bubble("Lazy and stupid.")
	await get_tree().create_timer(8.0).timeout
	world_root.show_bubble("*sigh*")
	await get_tree().create_timer(5.0).timeout
	world_root.show_bubble("Well, I hope you at least had some fun.", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Maybe you got a bit distracted from all the crap going on?", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("A tiny sliver of silly nonsense?")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("A chuckle, perhaps?")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("A snort?")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("A fart?")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("I could really use a laugh right now.", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("You know...", 3.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("You did stick around until the end, after all.", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("That says more about you than it does about me.", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("[ERROR: ENDING_NOT_FOUND]")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("Oh good, even the ending is buggy.", 4.0)
	world_root.show_bubble("Anyway.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Goodbye, I guess.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("...unless this loops.")
	await get_tree().create_timer(8.0).timeout
	world_root.show_bubble("Okay, something important is about to happen.")
	await get_tree().create_timer(8.0).timeout
	world_root.show_bubble("...nope.")
	await get_tree().create_timer(8.0).timeout
	world_root.show_bubble("We can just... stay here a bit longer.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("No rush. I'm sure the void can wait.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("No rush. No rush at all...", 4.0)
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("You know these pauses are just to pad runtime, right?", 4.0)
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("I'm being a bit dramatic, aren't I?")
	await get_tree().create_timer(4.0).timeout
	world_root.show_bubble("I stand by it.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("...hey.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Thanks for staying.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Even if it was a bad decision.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("And thanks for playing.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("It means a lot to me.")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Seriously.")
	await get_tree().create_timer(10.0).timeout
	world_root.show_bubble("Oh no, here it comes...")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Any second now...")
	await get_tree().create_timer(6.0).timeout
	world_root.show_bubble("Hold on to your butts...")
	await get_tree().create_timer(6.0).timeout
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enable_storytelling:
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
	player.input_enabled = true
	player.allow_signals = true
	
