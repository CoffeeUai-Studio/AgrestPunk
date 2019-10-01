extends Node2D

var can_use = true

signal slow()

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("gadget_b"):
		if can_use:
			$GadgetTimer_B.start()
			can_use = false
			emit_signal("slow", 6, .8)

func _on_GadgetTimer_B_timeout():
	can_use = true