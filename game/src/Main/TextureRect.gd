extends TextureRect


func _on_Icons_ammo_changed(current_ammo, max_ammo):
	$Number.text = "%s / %s" % [current_ammo, max_ammo]
