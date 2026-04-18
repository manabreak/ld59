class_name MessageArea
extends Area2D

@export var default_text: String = ""
@export var carry_text: String = ""
@export var one_shot: bool = true
@export var world_root: WorldRoot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(self.on_body_entered)
	self.body_exited.connect(self.on_body_exited)


func on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.carried_item == null || carry_text.is_empty():
			world_root.show_bubble(default_text)
		else:
			world_root.show_bubble(carry_text)
	elif body is Block:
		world_root.show_bubble(default_text)


func on_body_exited(body: Node2D) -> void:
	world_root.hide_bubble()
	if one_shot:
		queue_free()
