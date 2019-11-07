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
	_state_machine.transition_to("Move/Idle")
