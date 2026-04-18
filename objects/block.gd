class_name Block
extends RigidBody2D

var original_mask = 0
var original_layer = 0

var original_spawn_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_mask = collision_mask
	original_layer = collision_layer
	original_spawn_position = global_position
	$PickupArea.body_entered.connect(self.on_pickup_area_body_entered)
	$PickupArea.body_exited.connect(self.on_pickup_area_body_exited)


func _physics_process(delta: float) -> void:
	if global_position.y >= 10000.0:
		respawn()


func respawn() -> void:
	collision_layer = 0
	collision_mask = 0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	rotation = 0.0
	call_deferred("deferred_respawn")


func deferred_respawn() -> void:
	global_position = original_spawn_position
	collision_layer = original_layer
	collision_mask = original_mask


func on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player in pickup area")
		body.nearby_item = self


func on_pickup_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player exited pickup area")
		if body.nearby_item == self:
			body.nearby_item = null


func interact(player: Player) -> void:
	player.carried_item = self
	collision_mask = 0
	collision_layer = 0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	rotation = 0.0


func uninteract(player: Player) -> void:
	player.carried_item = null
	call_deferred("resume_block", player)


func resume_block(player: Player) -> void:
	var player_coords = player.global_position
	if player.facing_right:
		global_position = player_coords + Vector2(20.0, -12.0)
	else:
		global_position = player_coords + Vector2(-20.0, -12.0)
	linear_velocity.y = 0.0
	collision_mask = original_mask
	collision_layer = original_layer
