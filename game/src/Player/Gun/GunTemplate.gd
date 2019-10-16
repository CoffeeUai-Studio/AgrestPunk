extends Node2D

const fire_sfx = ['PISTOL_01', 'PISTOL_02', 'PISTOL_03']
const reload_sfx = ['RECARREGAR_ARMA_1', 'RECARREGAR_ARMA_2', 'RECARREGAR_ARMA_3']

export (PackedScene) var bullet #= preload("Bullet.tscn")

export (int) var max_ammo = 20
onready var current_ammo = max_ammo #setget set_ammo
export (float) var gun_cooldown = 0.4
export (int) var damage = 20
onready var muzzle: Position2D = $Muzzle

func _fire(aim_direction, _position):
	var new_bullet = bullet.instance()
	new_bullet.position = _position
	new_bullet.direction = aim_direction
	new_bullet.damage = damage
	add_child(new_bullet)
	print("Ammo:", current_ammo)