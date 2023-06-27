extends Area2D


var pontos = 10

func _on_Moeda_body_entered(body):
	if body.name == "player":
		queue_free()
		Game.pontos += pontos
