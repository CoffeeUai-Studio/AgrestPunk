extends State
"""
Perform ranged attacks at the direction that the character is aiming
"""


func _on_Skin_animation_finished(name: String) -> void:
	if name == "ranged":
		_state_machine.transition_to("Move/Run")


func enter(msg: Dictionary = {}) -> void:
	assert "move_state" in msg and msg.move_state is State
	
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finished")
	
	
	#check direction for the aiming from -pi/2 to pi/2, make the character face right
	# for -pi to -pi/2 and pi to pi/2 make the character face left
	
	
	var anim_dir = 6
	msg.move_state.velocity.y = 0.0
	owner.cabeca_sprite.play("Garra_Melee_Cabeca")
	owner.braco_sprite.play("Garra_Melee_Braco")
	owner.torso_sprite.play("Garra_Melee_Corpo")


func exit() -> void:
	owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finished")