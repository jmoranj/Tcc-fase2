extends Area2D

const RAPIDEZ = 100
var velocidade = Vector2()
var direcao = 1

func _ready():
	pass
	
func set_direcao_poder(dir):
	direcao = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	 
func _physics_process(delta):
	velocidade.x = RAPIDEZ * delta * direcao
	translate(velocidade)
	$AnimatedSprite.play("poder")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Poder_body_entered(body):
	if "inimigo" in body.name:
		body.estaMorto()
	queue_free()
