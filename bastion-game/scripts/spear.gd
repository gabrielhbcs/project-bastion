extends WeaponBase

func _ready() -> void:
	# Lança mais rápida que o normal
	atk_spd_base = 0.8
	att_duration = 0.2
	atk_spd = (atk_spd_base / metal_type.atk_spd_mod) + att_duration * 2
	preferred_muzzle = "CenterMuzzle"
	att_distance = 30
	super._ready()

func execute_attack(target: Node2D) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	var target_pos = char_muzzle.global_position + direction * att_distance
	look_at(target_pos)
	
	top_level = false
	var tween = create_tween()
	
	tween.tween_property(self, "global_position", target_pos, att_duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(_on_attack_back)
	
func _on_attack_back():
	look_at(char_muzzle.global_position)
	rotation += PI
	var tween = create_tween()
	
	tween.tween_property(self, "position", char_muzzle.position, att_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(_on_attack_finished)

func _on_attack_finished():
	top_level = false
	position = char_muzzle.position
