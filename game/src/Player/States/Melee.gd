extends State
"""
Makes the character execute alternating melee attacks
"""


func _on_Skin_animation_finished(name: String) -> void:
	if name == "ranged":
		_state_machine.transition_to("Move/Run")


func enter(msg: Dictionary = {}) -> void:
	assert "move_state" in msg and msg.move_state is State
	
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finished")
	
	var anim_dir = 6
	msg.move_state.velocity.y = 0.0
	owner.cabeca_sprite.play("Garra_Shot_" + anim_dir + "_Cabeca")
	owner.braco_sprite.play("Garra_Shot_" + anim_dir + "_Braco")
	owner.torso_sprite.play("Garra_Shot_" + anim_dir + "_Corpo")


func exit() -> void:
	owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finished")