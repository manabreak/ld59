class_name Checkpoint
extends Area2D

signal checkpoint_activated(checkpoint: Checkpoint)

var activated = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(self.on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if activated:
		return
	
	if body is Player:
		print("Checkpoint reached")
		activated = true
		emit_signal("checkpoint_activated", self)
