extends Node2D

var simultaneous_scene = preload("res://SwampLands.tscn")

func _process(delta):
	if Input.is_action_just_pressed("move_jump"):
		get_tree().change_scene_to(simultaneous_scene)
