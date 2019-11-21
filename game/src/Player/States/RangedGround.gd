extends State
"""
Perform ranged attacks at the direction that the character is aiming
"""

signal attack

onready var duration: Timer = $Duration
onready var braco = get_node("../../../Sprite_Player/Garra_Braco")
onready var attack = get_node("../../../Sprite_Player/Garra_BracoAttack")

var mouse_position = null
var direct = null

func enter(msg: Dictionary = {}) -> void:
	duration.start()
	braco.hide()
	attack.show()
	if mouse_position <= 22.5 && mouse_position >= -22.5:
		direct = "6" #front
		attack.rotation_degrees = mouse_position
		attack.position.x = 16
		attack.position.y = 4
	
	elif mouse_position >= 157.5 || mouse_position <= -157.5:
		direct = "6" #front
		attack.rotation_degrees = mouse_position - 180
		attack.position.x = 16
		attack.position.y = 4
	
	elif mouse_position > 22.5 && mouse_position <= 67.5:
		direct = "3" #downfront
		attack.rotation_degrees = mouse_position - 45
		attack.position.x = 15
		attack.position.y = 8
		
	elif mouse_position < 157.5 && mouse_position >= 112.5:
		direct = "3" #downfront
		attack.rotation_degrees = mouse_position - 180 + 45
		attack.position.x = 15
		attack.position.y = 8
		
	elif mouse_position > 67.5 && mouse_position <= 90 :
		direct = "2" #down
		attack.rotation_degrees = mouse_position - 90
		attack.position.x = 13
		attack.position.y = 10
		
	elif mouse_position > 90 && mouse_position < 112.5 :
		direct = "2" #down
		attack.rotation_degrees = mouse_position - 180 + 90
		attack.position.x = 13
		attack.position.y = 10
		
	elif mouse_position < -22.5 && mouse_position >= -67.5:
		direct = "9" #upfront
		attack.rotation_degrees = mouse_position + 45
		attack.position.x = 16
		attack.position.y = 1
		
	elif mouse_position > -157.5 && mouse_position <= -112.5:
		direct = "9" #upfront
		attack.rotation_degrees = mouse_position - 180 - 45
		attack.position.x = 16
		attack.position.y = 1
		
	elif mouse_position < -67.5 && mouse_position >= -90 :
		direct = "8" #up
		attack.rotation_degrees = mouse_position + 90
		attack.position.x = 1
		attack.position.y = -5
		
	elif mouse_position < -90 && mouse_position > -112.5 :
		direct = "8" #up
		attack.rotation_degrees = mouse_position - 180 - 90
		attack.position.x = 1
		attack.position.y = -5
		
	#attack.rotation_degrees = mouse_position
	print(attack.position)
	owner.cabeca_sprite.play("Garra_Shot_" + direct + "_Cabeca")
	owner.ataque_sprite.play("Garra_Shot_" + direct + "_Braco")
	owner.torso_sprite.play("Garra_Shot_" + direct + "_Corpo")
	emit_signal("attack")
	yield(duration, "timeout")
	attack.rotation_degrees = 0
	_state_machine.transition_to("Move/Idle")

func exit() -> void:
	braco.show()
	attack.hide()
	pass

