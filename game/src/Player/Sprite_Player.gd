extends Node2D

onready var movement = get_node("../StateMachine/Move")
var mouse

func _process(delta):
	mouse = get_global_mouse_position()
	if movement.velocity.x > 0:
		$Garra_Braco.flip_h = true
		$Garra_BracoAttack.flip_h = true
		$Garra_Cabeca.flip_h = true
		$Garra_Corpo.flip_h = true
	elif movement.velocity.x < 0:
		$Garra_Braco.flip_h = false
		$Garra_BracoAttack.flip_h = false
		$Garra_Cabeca.flip_h = false
		$Garra_Corpo.flip_h = false

func _input(event):
	if event.is_action_pressed("hook") || event.is_action_pressed("gun") || event.is_action_pressed("gadget_a") || event.is_action_pressed("gadget_b"):
		if owner.position.x < mouse.x:
			$Garra_Braco.flip_h = true
			$Garra_BracoAttack.flip_h = true
			$Garra_Cabeca.flip_h = true
			$Garra_Corpo.flip_h = true
		elif owner.position.x > mouse.x:
			$Garra_Braco.flip_h = false
			$Garra_BracoAttack.flip_h = false
			$Garra_Cabeca.flip_h = false
			$Garra_Corpo.flip_h = false