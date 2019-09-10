extends Control


func _ready():
	$Menu/CenterRow/Buttons/PlayButton.grab_focus()


func _process(delta):
	if $Menu/CenterRow/Buttons/PlayButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/PlayButton.grab_focus()
	if $Menu/CenterRow/Buttons/OptionsButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/OptionsButton.grab_focus()
	if $Menu/CenterRow/Buttons/QuitButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/QuitButton.grab_focus()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Main/Game.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://src/UI/Menu/Options.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
