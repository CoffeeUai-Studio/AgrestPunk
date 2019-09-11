extends Node2D

onready var granade = preload("res://src/Player/Gun/Granade.tscn")
"""
When all gadgets have a controller, make a timer for each gadget slot and make them 
the gadget timer from its controller
"""
func _ready():
	pass # Replace with function body.

func _launch(aim_direction):
	var new_granade = granade.instance()
	new_granade.direction = aim_direction
	add_child(new_granade)
	#granade._launch(aim_direction)
