extends Node2D

onready var active_gadget_a : Node2D = $GranadeController
var can_use = true
var aim_direction

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("gadget_a"):
		if can_use:
			$GadgetTimer_A.start()
			can_use = false
			match Settings.controls:
				Settings.GAMEPAD:
					aim_direction = Utils.get_aim_joystick_direction()
				Settings.KBD_MOUSE, _:
					aim_direction = (get_global_mouse_position() - global_position).normalized()
			active_gadget_a._launch(aim_direction)

func _on_GadgetTimer_A_timeout():
	can_use = true
