extends Node2D

const fire_sfx = ['TIRO_1', 'TIRO_2', 'TIRO_3']
const reload_sfx = ['RECARREGAR_ARMA_1', 'RECARREGAR_ARMA_2', 'RECARREGAR_ARMA_3']

var bullet = preload("Bullet.tscn")

export (int) var max_ammo = 20
onready var current_ammo = max_ammo #setget set_ammo
export (float) var gun_cooldown = 0.4
export (int) var damage = 1

func _fire(aim_direction):
	var new_bullet = bullet.instance()
	new_bullet.direction = aim_direction
	add_child(new_bullet)
	print("Ammo:", current_ammo)