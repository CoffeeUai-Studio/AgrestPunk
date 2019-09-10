extends Node

const TRANS =  Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0

onready var camera = get_parent()
onready var original_offset = camera.offset

func _start(duration = 0.2, frequency = 15, amplitude = 8, priority = 0):
	if priority >= self.priority:
		self.priority = priority
		self.amplitude = amplitude
		
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		$Duration.start()
		$Frequency.start()
		
		_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(camera.offset.x - amplitude, camera.offset.x + amplitude)
	rand.y = rand_range(camera.offset.y - amplitude, camera.offset.y + amplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, original_offset, $Frequency.wait_time, TRANS, EASE)
	#$ShakeTween.start()
	
	priority = 0



func _on_Duration_timeout():
	_reset()
	$Frequency.stop()


func _on_Frequency_timeout():
	_new_shake()

