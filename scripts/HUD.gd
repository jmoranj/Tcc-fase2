extends Control

onready var pause = $Pause
onready var cena = get_tree()

func _process(delta):
	$Pontos.text = "Pontos: %s" % Game.get_pontos()

func pausar (valor: bool):
	cena.paused = valor
	pause.visible = valor
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if cena .paused == false:
			pausar(true)
		else:
			pausar(false)
			
		cena.set_input_as_handled()
		
		
