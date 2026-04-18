class_name DebugUi
extends Control


func player_position_changed(position: Vector2) -> void:
	$PlayerPosLabel.text = "Player at %s" % position
