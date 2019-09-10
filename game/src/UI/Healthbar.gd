extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween
onready var downpdate_tween = $DownpdateTween

var bar_limit

func _on_Player_health_changed(health):
	if health <= health_over.value:
		health_over.value = health
		downpdate_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
		downpdate_tween.start()
	else:
		health_under.value = clamp(health, 0, bar_limit)
		update_tween.start()
		update_tween.interpolate_property(health_over, "value", health_over.value, health, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	


func _on_Player_max_health_changed(max_health):
	bar_limit = max_health
	health_over.max_value = max_health
	health_under.max_value = max_health
