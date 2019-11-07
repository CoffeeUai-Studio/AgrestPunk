extends Sprite

signal step

func _ready():
	pass # Replace with function body.


func _step():
	emit_signal("step") #add ground type variable
	
