class_name Beacon
extends Area2D

@export var light_pulse_scene: PackedScene
@export var world_root: WorldRoot
var lit = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(self.on_body_entered)
	# body_exited.connect(self.on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_body_entered(body: Node2D) -> void:
	if lit:
		return
	
	if body is Player:
		print("Player in beacon's area")
		if body.carried_item is Block && body.carried_item.name.begins_with("Crystal"):
			lit = true
			call_deferred("move_crystal", body)


func move_crystal(body: Player) -> void:
	print("Crystal at beacon!")
	var crystal_body = body.carried_item as Block
	var crystal = crystal_body.get_node("Sprite2D")
	crystal_body.remove_child(crystal)
	add_child(crystal)
	crystal.global_position = crystal_body.global_position
	crystal_body.queue_free()
	body.carried_item = null
	
	crystal.global_position = body.global_position + Vector2(0.0, -11.0)
	print("Crystal first at %s" % crystal.global_position)
	print("Tweening crystal to %s" % $CrystalSpot.global_position)
	var tween = create_tween()
	tween.tween_property(crystal, "global_position", $CrystalSpot.global_position, 2.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	await tween.finished
	print("Tween finished, crystal now at %s" % crystal.global_position)
	$ActivationSound.play()
	world_root.beacon_lit()
	world_root.light_manager.add_global_light($LightSprite)
	
	var pulse = light_pulse_scene.instantiate() as LightPulse
	pulse.global_position = $CrystalSpot.global_position
	pulse.burst_light_energy = 4.0
	pulse.burst_range = 3.0
	pulse.burst_time = 2.0
	pulse.burst_decay_time = 3.0
	
	pulse.reveal_light_energy = 1.5
	pulse.reveal_range = 2.5
	pulse.reveal_time = 0.1
	pulse.reveal_decay_time = 6.0
	
	world_root.add_pulse(pulse)


func interact(player: Player) -> void:
	print("Player interacting with beacon")
	if !lit:
		world_root.show_bubble("I guess we need a crystal.")
