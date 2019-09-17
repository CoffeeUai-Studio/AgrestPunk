extends KinematicBody2D

var velocity = Vector2()
var direction = Vector2()
var collision_info
var bouncyness = 0.5
export (int) var damage
export (float) var lifetime = .1

func _ready():
	$LifeTimer.wait_time = lifetime
	set_as_toplevel(true)
	_launch(direction)

func _launch(target_position):
	print("ahsiuahsa")
	var arc_height = target_position.y - global_position.y - 32
	arc_height = min(arc_height, -32)
	velocity = PhysicsHelper.calculate_arc_velocity(global_position, target_position, arc_height)
	velocity = velocity.clamped(50)

func _physics_process(delta):
	#velocity.y += 10 * delta
	#velocity = Vector2 (1,1)
	collision_info = move_and_collide(velocity * delta)
	#if collision_info != null:
	#	_on_impact(collision_info.normal)

func _on_impact(normal : Vector2):
	velocity = velocity.bounce(normal)
	velocity *= bouncyness

func _on_Granade_body_entered(body):
	if body.has_method('take_damage'):
		body.take_damage(damage)
	explode()

func explode():
	queue_free()

func _draw():
	draw_circle(Vector2(), $CollisionShape2D.shape.radius, Color('ff88ff'))


func _on_LifeTimer_timeout():
	explode()