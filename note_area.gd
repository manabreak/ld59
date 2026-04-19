class_name NoteArea
extends Area2D

@export var texts: Array[String] = []
@export var world_root: WorldRoot


func _ready() -> void:
	body_entered.connect(self.on_pickup_area_body_entered)
	body_exited.connect(self.on_pickup_area_body_exited)


func interact(player: Player) -> void:
	world_root.show_note(self)


func on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player in pickup area")
		body.nearby_item = self


func on_pickup_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player exited pickup area")
		if body.nearby_item == self:
			body.nearby_item = null
