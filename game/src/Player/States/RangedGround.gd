extends State
"""
Perform ranged attacks at the direction that the character is aiming
"""

signal attack

onready var duration: Timer = $Duration
onready var braco = get_node("../../../Sprite_Player/Garra_Braco")
onready var attack = get_node("../../../Sprite_Player/Garra_BracoAttack")

func enter(msg: Dictionary = {}) -> void:
	duration.start()
	braco.hide()
	attack.show()
	owner.cabeca_sprite.play("Garra_Shot_6_Cabeca")
	owner.ataque_sprite.play("Garra_Shot_6_Braco")
	owner.torso_sprite.play("Garra_Shot_6_Corpo")
	
	emit_signal("attack")
	yield(duration, "timeout")
	_state_machine.transition_to("Move/Idle")

func exit() -> void:
	braco.show()
	attack.hide()
	pass