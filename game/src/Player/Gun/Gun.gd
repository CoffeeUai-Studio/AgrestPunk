extends Node2D

signal shoot
signal ammo_changed

var aim_direction
var can_shoot = true

onready var active_gun: Node2D = $GunTemplate

#export (int) var gun_shots = 1
#export (float, 0, 1.5) var gun_spread = 0.2

func _ready():
	emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
	$GunTimer.wait_time = active_gun.gun_cooldown
	print("Ammo:", active_gun.current_ammo)

func _input(event):
	if event.is_action_pressed("gun"):
		if active_gun.current_ammo != 0 and can_shoot:
			active_gun.current_ammo -= 1
			$GunTimer.start()
			can_shoot = false
			#RandomizeSound.choose_random_sound(active_gun.fire_sfx)
			$GunStream.stream = load("res://assets/audio/sfx/player/gun/TIRO_1.wav")
			$GunStream.play()
			emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
			match Settings.controls:
				Settings.GAMEPAD:
					aim_direction = Utils.get_aim_joystick_direction()
				Settings.KBD_MOUSE, _:
					aim_direction = (get_global_mouse_position() - global_position).normalized()
			active_gun._fire(aim_direction)
	elif event.is_action_pressed("ui_right"):
		active_gun.current_ammo = active_gun.max_ammo
		emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
		$GunStream.stream = load("res://assets/audio/sfx/player/gun/RECARREGAR_ARMA_1.wav")
		$GunStream.play()


func set_ammo(value):
	if value > active_gun.max_ammo:
		value = active_gun.max_ammo
	if value > 0:
		$GunStream.stream = load("res://assets/audio/sfx/player/gun/RECARREGAR_ARMA_1.wav")
		$GunStream.play()
	active_gun.current_ammo = value
	emit_signal('ammo_changed', active_gun.current_ammo, active_gun.max_ammo)
	print("Ammo:", active_gun.current_ammo)

func _on_GunTimer_timeout():
	can_shoot = true