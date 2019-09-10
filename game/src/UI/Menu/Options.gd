extends Control

func _ready():
	if OS.window_fullscreen == true:
		$CenterRow/FullscreenToggle/CheckBox.set_pressed(true)


func _process(delta):
	if $CenterRow/Return.is_hovered() == true:
		$CenterRow/Return.grab_focus()
	if $CenterRow/Return.is_hovered() == false:
		$CenterRow/Return.release_focus()

func _on_Fullcreen_CheckBox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Return_pressed():
	get_tree().change_scene("res://src/UI/Menu/Title.tscn")
