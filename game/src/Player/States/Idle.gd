tool
extends State


onready var jump_delay: Timer = $JumpDelay

onready var head_sprite = get_node("../../../Sprite_Player/Garra_Cabeca/AnimationPlayer")
onready var arm_sprite = get_node("../../../Sprite_Player/Garra_Braco/AnimationPlayer")
onready var torso_sprite = get_node("../../../Sprite_Player/Garra_Corpo/AnimationPlayer")


func _get_configuration_warning() -> String:
	return "" if $JumpDelay else "%s requires a Timer child named JumpDelay" % name


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	torso_sprite.play("Garra_Idle_Corpo")
	head_sprite.play("Garra_Idle_Cabeca")
	arm_sprite.play("Garra_Idle_Braco")
	if owner.is_on_floor() and _parent.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	
	_parent.max_speed = _parent.max_speed_default
	_parent.velocity = Vector2.ZERO
	if jump_delay.time_left > 0.0:
		_state_machine.transition_to("Move/Air")


func exit() -> void:
	_parent.exit()
