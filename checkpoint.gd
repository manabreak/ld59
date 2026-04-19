class_name Checkpoint
extends Area2D

signal checkpoint_activated(checkpoint: Checkpoint)

var activated = false
@export var light_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light_sprite.visible = false
	light_sprite.global_position = self.global_position
	self.body_entered.connect(self.on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if activated:
		return
	
	if body is Player:
		print("Checkpoint reached")
		$ActivationSound.play()
		activated = true
		light_sprite.visible = true
		emit_signal("checkpoint_activated", self)
