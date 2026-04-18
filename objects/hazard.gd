class_name Hazard
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(self.on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player hit by a hazard")
		body.kill()
