extends Node2D

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