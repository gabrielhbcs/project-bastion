extends Node2D
class_name WeaponBase

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle

# Essas variáveis você preenche no Inspector de cada arma herdada
#@export var stats: WeaponStats 
#@export var metal_type: MetalType

func _ready() -> void:
	# Conecta o sinal do timer via código (mais limpo para o backend)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	print("Arma ", name, " equipada")
	setup_weapon()

func setup_weapon() -> void:
	#if stats:
	cooldown_timer.wait_time = 1.0
	cooldown_timer.start()

func _on_cooldown_timer_timeout() -> void:
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
