extends CharacterBody2D

const SPEED_MAX = 100.0
const JUMP_VELOCITY_INITIAL = -200.0
const JUMP_APPLY_TIME = 1.0
const JUMP_APPLY_FORCE = -12.0

@export var light_pulse_scene: PackedScene
@export var world_root: WorldRoot

var jump_timer = 0.0
var facing_right = true

var step_timer = 0.0
var walking = false
var floored = false

func _physics_process(delta: float) -> void:
	
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		floored = false
	else:
		if !floored:
			print("Land!")
			create_land_pulse()
			
		floored = true

	# Handle jump
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY_INITIAL
		jump_timer = JUMP_APPLY_TIME
	elif Input.is_action_pressed("jump") && jump_timer > 0:
		velocity.y += JUMP_APPLY_FORCE * jump_timer
		jump_timer -= delta
	else:
		jump_timer = 0.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. 
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED_MAX
		if velocity.x > 0.0:
			facing_right = true
		else:
			facing_right = false
		if !walking:
			step_timer = 0.0
		walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_MAX)
		walking = false
	
	if is_on_floor() && walking:
		step_timer -= delta
		if step_timer <= 0.0:
			# print("Step %d" % Time.get_ticks_msec())
			step_timer += 0.5
			create_step_pulse()
	
	move_and_slide()


func create_land_pulse() -> void:
	print("Land pulse boom")
	var pulse = light_pulse_scene.instantiate() as LightPulse
	pulse.global_position = self.global_position + Vector2(0.0, 11.0)
	pulse.burst_light_energy = 1.0
	pulse.burst_range = 2.0
	pulse.burst_time = 2.0
	pulse.burst_decay_time = 3.0
	
	pulse.reveal_light_energy = 1.5
	pulse.reveal_range = 2.5
	pulse.reveal_time = 0.1
	pulse.reveal_decay_time = 6.0
	
	world_root.add_pulse(pulse)


func create_step_pulse() -> void:
	var pulse = light_pulse_scene.instantiate() as LightPulse
	pulse.global_position = self.global_position + Vector2(0.0, 11.0)
	pulse.burst_light_energy = 0.5
	pulse.burst_range = 2.0
	pulse.burst_time = 2.0
	pulse.burst_decay_time = 2.0
	
	pulse.reveal_light_energy = 1.0
	pulse.reveal_range = 2.0
	pulse.reveal_time = 0.5
	pulse.reveal_decay_time = 6.0
	
	world_root.add_pulse(pulse)
