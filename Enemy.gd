extends Area2D

signal damage_player
signal fireball_hit

func _on_Enemy_area_shape_entered(area_id, area, area_shape, self_shape):
	print("Fireball hit")
	emit_signal("fireball_hit")
	call_deferred("free")


func _on_Enemy_body_entered(body):
	print("Player hit")
	emit_signal("damage_player")
