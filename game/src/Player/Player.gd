extends KinematicBody2D
class_name Player

signal health_changed(health)
signal max_health_changed(max_health)
signal shake()
signal killed()

onready var state_machine: StateMachine = $StateMachine

onready var hook: Position2D = $Hook

onready var skin: Position2D = $Skin
onready var collider: CollisionShape2D = $CollisionShape2D

#onready var stats: Stats = $Stats
onready var hitbox: Area2D = $HitBox
"""
onready var camera_rig: Position2D = $CameraRig
onready var shaking_camera: Camera2D = $CameraRig/ShakingCamera
"""
onready var ledge_wall_detector: Position2D = $LedgeWallDetector
onready var floor_detector: RayCast2D = $FloorDetector
onready var invulnerability_timer: Timer = $InvulnerabilityTimer
onready var effect_animation: AnimationPlayer = $EffectAnimation
onready var player_stream: AudioStreamPlayer = $PlayerStream

onready var pass_through: Area2D = $PassThrough

export (int) var max_health = 100
onready var health = max_health setget set_health

const FLOOR_NORMAL: = Vector2.UP

var is_active: = true setget set_is_active
var has_teleported: = false


func _ready() -> void:
	#stats.connect("health_depleted", state_machine, "transition_to", ['Die'])
	emit_signal('max_health_changed', max_health)
	emit_signal('health_changed', health)

func set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal('health_changed', health)
		print("HP:", health)
		if health == 0:
			dies()
			print("DEAD")
	#stats.take_damage(source)

func take_damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		set_health(health - amount)
		emit_signal("shake")
		effect_animation.play("Damage")
		effect_animation.queue("InvulnerabilityFlash")
		$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/DANO_1.wav")
		$PlayerStream.play()

func dies():
	queue_free()

func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value
	hook.is_active = value
	ledge_wall_detector.is_active = value
	hitbox.monitoring = value

func _input(event):
	if event.is_action_pressed("ui_down"):
		take_damage(10)
	elif event.is_action_pressed("ui_up"):
		set_health(health+30)
	elif event.is_action_pressed("ui_left"):
		emit_signal("shake")
	elif event.is_action_pressed("melee"):
		effect_animation.play("MeleeTemp")
		$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/PEIXEIRA_1.wav")
		$PlayerStream.play()

func _on_InvulnerabilityTimer_timeout():
	effect_animation.play("Rest")


func _on_Air_jumped():
	$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/PULO_1.wav")
	$PlayerStream.play()


func _on_step():
	$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/CORRER_1.wav")
	$PlayerStream.play()
