class_name RotatingCross
extends Node2D

@export var speed: float = 25.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PinJoint2D.motor_target_velocity = deg_to_rad(speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
