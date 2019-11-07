extends State
"""
Makes the character execute alternating melee attacks
"""

signal attack

onready var duration: Timer = $Duration


func enter(msg: Dictionary = {}) -> void:
	duration.start()
	
	emit_signal("attack")
	yield(duration, "timeout")
	_state_machine.transition_to("Move/Air")

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
		duration.stop()