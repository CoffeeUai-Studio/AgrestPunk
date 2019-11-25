extends RichTextLabel

var dialog = ["Hello cruel world...", "Goodbye cruel wordl..."]
var page = 0

#to let the player interact with the dialog box, on the trigger set_procces_input(true) to the box and false to the player

func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)#this one to the trigger

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
