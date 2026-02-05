extends WeaponBase

func _ready() -> void:
	# Lança mais rápida que o normal
	atk_spd_base = 0.8
	preferred_muzzle = "MeleeMuzzle"
	super._ready()

func execute_attack(target: Node2D) -> void:
	print(name, " disparou!")
