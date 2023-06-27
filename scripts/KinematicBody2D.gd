extends KinematicBody2D

const PULO = Vector2(0, -1)

const PODER = preload("res://scenes/Poder.tscn")

var velocidade = Vector2()

var no_chao = false

var atacando = false

var morto = false

func _physics_process(delta):
	velocidade.y += 10
	
	if morto == false:
	
		if Input.is_action_pressed("ui_right"):
			if atacando == false or is_on_floor() == false:
				velocidade.x = 100
				if atacando == false:
					$AnimationPlayer.play("andar_frente")
		elif Input.is_action_pressed("ui_left"):
			if atacando == false or is_on_floor() == false:
				velocidade.x = -100
				if atacando == false:
					$AnimationPlayer.play("andar_tras")
		else:
			velocidade.x = 0
			if no_chao == true && atacando == false:
				$AnimationPlayer.play("parado")
		
		if Input.is_action_just_pressed("poder") && atacando == false:
			atacando = true
			$AnimationPlayer.play("ataque")
			var poder = PODER.instance()
			if sign($Position2D.position.x) == 1:
				poder.set_direcao_poder(1)
			else:
				poder.set_direcao_poder(-1)
			get_parent().add_child(poder)
			poder.global_position = $Position2D.global_position
		
		if is_on_floor():
			if Input.is_action_pressed("ui_up"):
				if atacando == false:
					velocidade.y = -200
				
		if is_on_floor():
			if no_chao == false:
				atacando = false
			no_chao = true
		else:
			if atacando == false:
				no_chao = false
				if velocidade.y < 0:
					$AnimationPlayer.play("pulo")
				else:
					$AnimationPlayer.play("parado")	
				
		velocidade = move_and_slide(velocidade,PULO)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "inimigo" in get_slide_collision(i).collider.name:
					morte()
		
func morte():
	morto = true
	velocidade = Vector2(0,0)
	$AnimationPlayer.play("morto")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	atacando = false


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/fase1.tscn")
