extends KinematicBody2D
class_name Player

signal health_changed(health)
signal max_health_changed(max_health)
signal shake()
signal slow()
signal killed()

const jump_sfx = ['PULO_1', 'PULO_2', 'PULO_3']
const walk_sfx = ['CORRER_1', 'CORRER_2', 'CORRER_3']
const damage_sfx = ['CORTE_DANO_01', 'CORTE_DANO_02', 'CORTE_DANO_03']
const slash_sfx = ['CORTE_01', 'CORTE_02', 'CORTE_03']

onready var rSound

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
onready var player_stream: AudioStreamPlayer = $PlayerStream

onready var pass_through: Area2D = $PassThrough

onready var cabeca_sprite = get_node("Sprite_Player/Garra_Cabeca/AnimationPlayer")
onready var braco_sprite = get_node("Sprite_Player/Garra_Braco/AnimationPlayer")
onready var torso_sprite = get_node("Sprite_Player/Garra_Corpo/AnimationPlayer")
onready var effect_animation = get_node("Sprite_Player/EffectAnimation")

onready var move_param = get_node("StateMachine/Move")

export (int) var max_health = 100
onready var health = max_health setget set_health

const FLOOR_NORMAL: = Vector2.UP

var is_active: = true setget set_is_active
var has_teleported: = false

var inventory = []

var canMove = true
var canInteract = false

var target = null

func _ready() -> void:
	#stats.connect("health_depleted", state_machine, "transition_to", ['Die'])
	emit_signal('max_health_changed', max_health)
	emit_signal('health_changed', health)

func _physics_process(delta):
	#if move_param.max_speed.x > move_param.max_speed_default.x:
		
	var rot = get_angle_to(get_global_mouse_position())
	print(rot)

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
		emit_signal("slow", .2, .9)
		effect_animation.play("Damage")
		effect_animation.queue("InvulnerabilityFlash")
		rSound = RandomizeSound.choose_random_sound(damage_sfx)
		$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/" + rSound + ".wav")
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
	if(canInteract and event.is_action_pressed("interact")):
		print("Interacting with " + target.get_name())
		
		get_node("../../DialogueParser").init_dialogue(target.get_name())
		canMove = false
		
		target.action(inventory)
		
		if(target.is_in_group("Item") and inventory.find(target.get_name()) < 0):
			inventory.append(target.get_name())
			print(inventory)
	if event.is_action_pressed("ui_down"):
		take_damage(10)
	elif event.is_action_pressed("ui_up"):
		set_health(health+30)
	elif event.is_action_pressed("ui_left"):
		emit_signal("shake")
	elif event.is_action_pressed("melee"):
		effect_animation.play("MeleeTemp")
		rSound = RandomizeSound.choose_random_sound(slash_sfx)
		$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/" + rSound + ".wav")
		$PlayerStream.play()
		cabeca_sprite.play("Garra_Melee_Cabeca")
		braco_sprite.play("Garra_Melee_Braco")
		torso_sprite.play("Garra_Melee_Corpo")

func _on_InvulnerabilityTimer_timeout():
	effect_animation.play("Rest")


func _on_Air_jumped():
	rSound = RandomizeSound.choose_random_sound(jump_sfx)
	$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/" + rSound + ".wav")
	$PlayerStream.play()
	cabeca_sprite.play("Garra_Jump_Cabeca")
	braco_sprite.play("Garra_Jump_Braco")
	torso_sprite.play("Garra_Jump_Corpo")


func _on_step():
	rSound = RandomizeSound.choose_random_sound(walk_sfx)
	$PlayerStream.stream = load("res://assets/audio/sfx/player/movement/" + rSound + ".wav")
	$PlayerStream.play()


#check which NPC is interactable
func _on_Area2D_body_enter(body, obj):
	if(body.get_parent().get_name() == "Player"):
		canInteract = true
		target = obj
	
func _on_Area2D_body_exit(body, obj):
	if(body.get_parent().get_name() == "Player"):
		canInteract = false
		target = null
