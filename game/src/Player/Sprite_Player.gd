extends Node2D

onready var movement = get_node("../StateMachine/Move")


func _process(delta):
	if movement.velocity.x > 0:
		$Garra_Braco.flip_h = true
		$Garra_Cabeca.flip_h = true
		$Garra_Corpo.flip_h = true
	elif movement.velocity.x < 0:
		$Garra_Braco.flip_h = false
		$Garra_Cabeca.flip_h = false
		$Garra_Corpo.flip_h = false
	pass