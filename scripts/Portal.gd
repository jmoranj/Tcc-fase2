extends Area2D

export var proximaFase: PackedScene



func _on_Portal_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to(proximaFase)
