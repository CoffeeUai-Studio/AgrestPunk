extends Node2D

signal shoot
signal ammo_changed

var aim_direction
var can_shoot = true

onready var templategun: Node2D = $GunTemplate
onready var shotgun: Node2D = $Shotgun
onready var active_gun
onready var _position
onready var rSound

#export (int) var gun_shots = 1
#export (float, 0, 1.5) var gun_spread = 0.2

func _ready():
	active_gun = templategun
	emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
	$GunTimer.wait_time = active_gun.gun_cooldown


func _physics_process(delta):
	look_at(get_global_mouse_position())


func _input(event):
	if event.is_action_pressed("ui_right"):
		active_gun.current_ammo = active_gun.max_ammo
		emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
		rSound = RandomizeSound.choose_random_sound(active_gun.reload_sfx)
		$GunStream.stream = load("res://assets/audio/sfx/player/gun/" + rSound + ".wav")
		$GunStream.play()
	elif event.is_action_pressed("change_ammo"):
		if active_gun == templategun:
			active_gun = shotgun
			emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
			$GunTimer.wait_time = active_gun.gun_cooldown
		elif active_gun == shotgun:
			active_gun = templategun
			emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
			$GunTimer.wait_time = active_gun.gun_cooldown


func set_ammo(value):
	if value > active_gun.max_ammo:
		value = active_gun.max_ammo
	if value > 0:
		rSound = RandomizeSound.choose_random_sound(active_gun.reload_sfx)
		$GunStream.stream = load("res://assets/audio/sfx/player/gun/" + rSound + ".wav")
		$GunStream.play()
	active_gun.current_ammo = value
	emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)

func _on_GunTimer_timeout():
	can_shoot = true

"""
func _on_Gadget_B_slow():
	$GunTimer.wait_time = active_gun.gun_cooldown / 10


func _on_GadgetTimer_B_timeout():
	$GunTimer.wait_time = active_gun.gun_cooldown
"""

func _on_Ranged_attack():
	if active_gun.current_ammo != 0 and can_shoot:
		active_gun.current_ammo -= 1
		$GunTimer.start()
		can_shoot = false
		rSound = RandomizeSound.choose_random_sound(active_gun.fire_sfx)
		$GunStream.stream = load("res://assets/audio/sfx/player/gun/" + rSound  +".wav")
		$GunStream.play()
		emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
		match Settings.controls:
			Settings.GAMEPAD:
				aim_direction = Utils.get_aim_joystick_direction()
			Settings.KBD_MOUSE, _:
				aim_direction = (get_global_mouse_position() - global_position).normalized()
		_position = $Muzzle.position
		active_gun._fire(aim_direction, _position)
