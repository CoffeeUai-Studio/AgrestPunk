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
	if mouse_position <= 22.5 && mouse_position >= -22.5 || mouse_position >= 157.5 || mouse_position <= -157.5:
		direct = "6" #front
	elif mouse_position > 22.5 && mouse_position <= 67.5 || mouse_position < 157.5 && mouse_position >= 112.5:
		direct = "3" #downfront
	elif mouse_position > 67.5 && mouse_position < 112.5 :
		direct = "2" #down
	elif mouse_position < -22.5 && mouse_position >= -67.5 || mouse_position > -157.5 && mouse_position <= -112.5:
		direct = "9" #upfront
	elif mouse_position < -67.5 && mouse_position > -112.5 :
		direct = "8" #up
	#attack.rotation_degrees = mouse_position
	owner.cabeca_sprite.play("Garra_Shot_" + direct + "_Cabeca")
	owner.ataque_sprite.play("Garra_Shot_" + direct + "_Braco")
	owner.torso_sprite.play("Garra_Shot_" + direct + "_Corpo")
	emit_signal("attack")
	yield(duration, "timeout")
	_state_machine.transition_to("Move/Air")

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
		duration.stop()

func exit() -> void:
	braco.show()
	attack.hide()
	pass
