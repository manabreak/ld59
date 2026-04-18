class_name WorldRoot
extends Node2D

@export var main_camera: Camera2D
@export var light_camera: Camera2D
@export var light_manager: LightManager

@export var checkpoints: Array[Checkpoint] = []

var initial_spawn_position: Vector2
var last_checkpoint: Checkpoint = null


func _ready() -> void:
	initial_spawn_position = $Player.global_position
	
	for c in get_children():
		if c is Checkpoint:
			checkpoints.append(c)
			c.checkpoint_activated.connect(self.on_checkpoint_activated)
		elif c is Player:
			c.player_died.connect(self.on_player_died)


func on_checkpoint_activated(checkpoint: Checkpoint) -> void:
	last_checkpoint = checkpoint


func on_player_died(player: Player) -> void:
	print("on player died")
	if last_checkpoint != null:
		player.global_position = last_checkpoint.global_position
	else:
		player.global_position = initial_spawn_position


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_kill_player"):
		print("Kill player")
		$Player.kill()
	
	if light_camera:
		light_camera.global_position = main_camera.global_position
	if light_manager:
		light_manager.player_position_changed($Player.global_position)


func add_pulse(pulse: LightPulse) -> void:
	if light_manager:
		light_manager.add_pulse(pulse)
