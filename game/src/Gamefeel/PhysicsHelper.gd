extends Node
class_name PhysicsHelper

static func calculate_arc_velocity(point_a, point_b, arc_height, gravity = 400):
	var velocity = Vector2()
	var displacement = point_b - point_a
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height / float(gravity))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(gravity))
		
		velocity.y = -sqrt(-2 * gravity * arc_height)
		velocity.x = displacement.x / float(time_up + time_down)
		#curva de bezier
	return velocity