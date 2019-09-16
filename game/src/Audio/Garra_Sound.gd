extends Sprite

signal step

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _step():
	emit_signal("step") #add ground type variable