extends State

onready var rSound

const hook_sfx = ['TIRO_CORDA_SAINDO_01', 'TIRO_CORDA_SAINDO_02', 'TIRO_CORDA_SAINDO_03']

func _on_Cooldown_timeout() -> void:
	_state_machine.transition_to("Aim")


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	owner.cooldown.connect("timeout", self, "_on_Cooldown_timeout")

	rSound = RandomizeSound.choose_random_sound(hook_sfx)
	$FirehookStream.stream = load("res://assets/audio/sfx/player/hook/" + rSound + ".wav")
	$FirehookStream.play()

	owner.is_aiming = false

	var target: HookTarget = owner.snap_detector.target
	if not target:
		var distance: = min(owner._radius, owner.get_local_mouse_position().length())
		owner.arrow.hook_position = owner.global_position + owner.get_local_mouse_position().normalized() * distance
		_state_machine.transition_to("Aim")
		return

	owner.arrow.hook_position = target.global_position
	target.hooked_from(owner.global_position)

	owner.cooldown.start()

	owner.emit_signal("hooked_onto_target", target.global_position)


func exit() -> void:
	owner.cooldown.disconnect("timeout", self, "_on_Cooldown_timeout")
