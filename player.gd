class_name Player
extends CharacterBody2D

const SPEED_MAX = 70.0
const JUMP_VELOCITY_INITIAL = -180.0
const JUMP_APPLY_TIME = 1.0
const JUMP_APPLY_FORCE = -10.0
const COYOTE_TIME = 0.2

signal player_died(player: Player)

@export var light_pulse_scene: PackedScene
@export var world_root: WorldRoot

var jump_timer = 0.0
var facing_right = true
var input_enabled = true

var step_timer = 0.0
var walking = false
var floored = false
var coyote_timer = 0.0

var nearby_item: Node2D = null
var carried_item: Block = null

var allow_signals = true

func _ready() -> void:
	$LandingParticles.emitting = false
	$Sprite2D.play("idle")


func kill() -> void:
	$KillSound.play()
	emit_signal("player_died", self)


func _physics_process(delta: float) -> void:
	if carried_item != null:
		carried_item.global_position = global_position + Vector2(0.0, -11.0)
	
	# Interact
	if input_enabled && Input.is_action_just_pressed("interact"):
		print("Interact")
		if carried_item != null:
			$UninteractSound.play()
			carried_item.uninteract(self)
		elif nearby_item != null:
			if nearby_item is Block || nearby_item is NoteArea || nearby_item is Beacon:
				print("Interact with %s" % nearby_item.name)
				$InteractSound.play()
				nearby_item.interact(self)
	
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if floored:
			coyote_timer = COYOTE_TIME
		floored = false
		coyote_timer -= delta
	else:   
		if !floored:
			$LandSound.play()
			create_land_pulse()
			
		floored = true

	# Handle jump
	if input_enabled && Input.is_action_just_pressed("jump") && (is_on_floor() || coyote_timer > 0.0):
		jump()
	elif input_enabled && Input.is_action_pressed("jump") && jump_timer > 0:
		velocity.y += JUMP_APPLY_FORCE * jump_timer
		jump_timer -= delta
	else:
		jump_timer = 0.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. 
	var direction := Input.get_axis("move_left", "move_right")
	if input_enabled && direction:
		velocity.x = direction * SPEED_MAX
		if velocity.x > 0.0:
			facing_right = true
			$Sprite2D.flip_h = false
		else:
			facing_right = false
			$Sprite2D.flip_h = true
		if !walking:
			step_timer = 0.0
		walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_MAX)
		walking = false
	
	if is_on_floor() && walking:
		step_timer -= delta
		if step_timer <= 0.0:
			step_timer += 0.3
			$WalkSound.pitch_scale = randf_range(0.8, 1.2)
			$WalkSound.play()
			create_step_pulse()
	
	move_and_slide()
	
	if is_on_floor():
		if abs(velocity.x) > 1.0:
			if carried_item != null:
				$Sprite2D.play("walk_carry")
			else:
				$Sprite2D.play("walk")
		else:
			if carried_item != null:
				$Sprite2D.play("idle_carry")
			else:
				$Sprite2D.play("idle")
	
	if global_position.y > 10000.0:
		kill()


func jump() -> void:
	velocity.y = JUMP_VELOCITY_INITIAL
	jump_timer = JUMP_APPLY_TIME
	coyote_timer = 0.0
	$JumpSound.pitch_scale = randf_range(0.8, 1.2)
	$JumpSound.play()


func set_flipped(flipped: bool) -> void:
	$Sprite2D.flip_h = flipped


func create_land_pulse() -> void:
	if !allow_signals:
		return
	
	var pulse = light_pulse_scene.instantiate() as LightPulse
	pulse.global_position = self.global_position + Vector2(0.0, 11.0)
	pulse.burst_light_energy = 1.0
	pulse.burst_range = 1.0 
	pulse.burst_time = 2.0
	pulse.burst_decay_time = 3.0
	
	pulse.reveal_light_energy = 1.5
	pulse.reveal_range = 0.8
	pulse.reveal_time = 0.1
	pulse.reveal_decay_time = 6.0
	
	world_root.add_pulse(pulse)


func create_step_pulse() -> void:
	if !allow_signals:
		return
	
	var pulse = light_pulse_scene.instantiate() as LightPulse
	pulse.global_position = self.global_position + Vector2(0.0, 11.0)
	pulse.burst_light_energy = 0.5
	pulse.burst_range = 0.3
	pulse.burst_time = 2.0
	pulse.burst_decay_time = 2.0
	
	pulse.reveal_light_energy = 1.0
	pulse.reveal_range = 0.67
	pulse.reveal_time = 0.5
	pulse.reveal_decay_time = 6.0
	
	world_root.add_pulse(pulse)
