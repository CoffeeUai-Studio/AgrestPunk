extends KinematicBody2D
class_name Enemy

signal health_changed(health)
signal max_health_changed(max_health)
signal killed()

const fire_sfx = ['PISTOL_01', 'PISTOL_02', 'PISTOL_03']

export (int) var max_health = 50
export (int) var speed
export (int) var detect_radius = 100
export (int) var percept_radius = 350
export (float) var rotation_speed = 20
export (float) var aiming_speed = 2
export (float) var gun_cooldown = 1

export (PackedScene) var bullet

onready var health = max_health setget set_health

onready var _position
onready var rSound

onready var effect_animation = get_node("Sprite_Enemy/EffectAnimation")

var target = null

onready var turret_current_dir
onready var drone_current_dir

func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DetectionRadius/CollisionShape2D.shape.radius = detect_radius
	$PerceptibleRadius/CollisionShape2D.shape.radius = percept_radius

func _physics_process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		drone_current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		turret_current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		$Sprite_Enemy.global_rotation = drone_current_dir.linear_interpolate(target_dir, rotation_speed * delta).angle()
		$Turret.global_rotation = turret_current_dir.linear_interpolate(target_dir, aiming_speed * delta).angle()

func set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal('health_changed', health)
		print("HP:", health)
		if health == 0:
			dies()

func take_damage(amount):
	set_health(health - amount)
	effect_animation.play("Damage")
	effect_animation.queue("Rest")
	#effect_animation.queue("InvulnerabilityFlash")
	#$EnemyStream.stream = load("res://assets/audio/sfx/player/movement/DANO_1.wav")
	#$EnemyStream.play()

func dies():
	queue_free()

func _on_DetectionRadius_body_entered(body):
	if body is Player:
		target = body


func _on_PerceptibleRadius_body_exited(body):
	if body == target:
		target = null


func _on_Aiming_body_entered(body):
	if body is Player:
		target = body
		$GunTimer.start()


func _on_GunTimer_timeout():
	var new_bullet = bullet.instance()
	new_bullet.position = $Turret/Sprite/Muzzle.global_position
	new_bullet.direction = turret_current_dir
	print(turret_current_dir)
	#new_bullet.damage = damage
	add_child(new_bullet)

