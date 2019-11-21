extends KinematicBody2D

var motion
var collision_info
var direction = Vector2()
export (int) var speed = 1000
export (int) var damage = 10
export (float) var lifetime #= .5



func _ready():
	$LifeTimer.wait_time = lifetime
	set_as_toplevel(true)


func _physics_process(delta):
	motion = direction * speed * delta
	collision_info = move_and_collide(motion)
	if collision_info:
		explode()


func _on_Bullet_body_entered(body):
	if body.has_method('take_damage'):
		print('notboom')
		body.take_damage(damage)
	explode()

func explode():
	queue_free()

func _draw():
	draw_circle(Vector2(), $CollisionShape2D.shape.radius, Color('#ffffff'))


func _on_LifeTimer_timeout():
	explode()
