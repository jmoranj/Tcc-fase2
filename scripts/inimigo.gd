extends KinematicBody2D

const GRAVIDADE = 10
const RAPIDEZ = 30
const CHAO = Vector2(0,1)

var velocidade = Vector2()
var direcao = 1
var morto = false

func _ready():
	pass
	
func estaMorto():
	morto = true
	$CollisionShape2D.disabled = true
	velocidade = Vector2(0,0)
	$Timer.start()
	$AnimatedSprite.play("explosao")
	Game.pontos += 50
	
func _physics_process(delta):
	if morto == false:
		velocidade.x = RAPIDEZ * direcao
	
		if direcao == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("andar")
	
		velocidade.y += GRAVIDADE

		velocidade = move_and_slide(velocidade,CHAO)
	
	if is_on_wall():
		direcao = direcao * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direcao = direcao * -1
		$RayCast2D.position.x *= -1


func _on_Timer_timeout():
	queue_free()
	
