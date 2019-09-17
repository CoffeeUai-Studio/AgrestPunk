extends State
"""
Horizontal movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""
onready var head_sprite = get_node("../../../Sprite_Player/Garra_Cabeca/AnimationPlayer")
onready var arm_sprite = get_node("../../../Sprite_Player/Garra_Braco/AnimationPlayer")
onready var torso_sprite = get_node("../../../Sprite_Player/Garra_Corpo/AnimationPlayer")


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor():
		if _parent.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle")
		else:
			torso_sprite.play("Garra_Walk_Corpo")
			head_sprite.play("Garra_Walk_Cabeca")
			arm_sprite.play("Garra_Walk_Braco")
	else:
		_state_machine.transition_to("Move/Air")
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()