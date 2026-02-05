extends Node2D
class_name WeaponBase

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_muzzle: Marker2D = $Muzzle

var char_muzzle: Marker2D
@export var preferred_muzzle: String = "CenterMuzzle"

# Essas variáveis você preenche no Inspector de cada arma herdada
#@export var stats: WeaponStats 
@export var metal_type: Resource

# atk spd final da arma
var atk_spd = 1.0
# atk spd base da arma (antes dos mods)
var atk_spd_base = 1.0

func _ready() -> void:
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	atk_spd = atk_spd_base / metal_type.atk_spd_mod
	
	char_muzzle = get_parent().get_parent().get_node(preferred_muzzle)
	global_position = char_muzzle.global_position
	
	print("Arma ", name, " de ", metal_type.name, " equipada")
	setup_weapon()

func setup_weapon() -> void:
	cooldown_timer.wait_time = atk_spd
	cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	# Ataque padrão, acha um alvo e ataca
	global_position = char_muzzle.global_position
	var target = find_target()
	execute_attack(target)
	if target:
		execute_attack(target)

# MÉTODO "ABSTRATO": Toda arma que herdar desta cena deve sobrescrever isso
func execute_attack(_target: Node2D) -> void:
	print("Ataque não implementado para: ", name)

func find_target() -> Node2D:
	# Implementação básica de busca
	var enemies = get_tree().get_nodes_in_group("enemies")
	# ... lógica de distância ...
	return enemies[0] if not enemies.is_empty() else null
