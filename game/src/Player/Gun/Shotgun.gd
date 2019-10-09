extends Node2D
#Shotgun

const fire_sfx = ['TIRO_1', 'TIRO_2', 'TIRO_3']
const reload_sfx = ['RECARREGAR_ARMA_1', 'RECARREGAR_ARMA_2', 'RECARREGAR_ARMA_3']

export (PackedScene) var bullet #= preload("Bullet.tscn")

export (int) var max_ammo = 10
onready var current_ammo = max_ammo #setget set_ammo
export (float) var gun_cooldown = 0.6
export (int) var damage = 10
export (int) var nshots = 1
export (float) var spread = .5

func _fire(aim_direction, _position):
	for i in range(nshots):
		var new_bullet = bullet.instance()
		var bullet_spread = randf() * spread * sign(rand_range(-1, 1))
		new_bullet.position = _position
		new_bullet.direction = (aim_direction + Vector2(0, bullet_spread)).normalized()
		new_bullet.damage = damage
		add_child(new_bullet)
	print("Ammo:", current_ammo)