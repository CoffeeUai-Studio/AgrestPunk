extends Control

signal ammo_changed(current_ammo, max_ammo)

func _on_Gun_ammo_changed(current_ammo, max_ammo):
	emit_signal('ammo_changed', current_ammo, max_ammo)