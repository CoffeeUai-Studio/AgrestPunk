extends Control

export (String, FILE) var text_dialogue
#var result_json = JSON.parse(text_json)
#var result = {}

func _ready():
	$Menu/CenterRow/Buttons/PlayButton.grab_focus()
	var data_file = File.new()
	if data_file.open(text_dialogue, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
		#print("Error: ", result_json.error)
		#print("Error Line: ", result_json.error_line)
		#print("Error String: ", result_json.error_string)
	var data = data_parse.result
	print(data["001"]["text"])
	print(data["002"]["text"])
	


func _process(delta):
	if $Menu/CenterRow/Buttons/PlayButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/PlayButton.grab_focus()
	if $Menu/CenterRow/Buttons/OptionsButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/OptionsButton.grab_focus()
	if $Menu/CenterRow/Buttons/CreditsButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/CreditsButton.grab_focus()
	if $Menu/CenterRow/Buttons/QuitButton.is_hovered() == true:
		$Menu/CenterRow/Buttons/QuitButton.grab_focus()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Main/Game.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://src/UI/Menu/Options.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://assets/UI/EndScene.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
