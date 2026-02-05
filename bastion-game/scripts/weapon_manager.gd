extends Node2D

# Aqui você arrasta as cenas (.tscn) das armas que quer testar
@export var starting_weapon: PackedScene 
@onready var MeleeMuzzle: Marker2D = $MeleeMuzzle
@onready var CenterMuzzle: Marker2D = $CenterMuzzle
#@export var test_metal: MetalType # Seu Resource de Metal (ex: Ferro)

func _ready():
	if starting_weapon:
		equip_weapon(starting_weapon)

func equip_weapon(weapon_scene: PackedScene):
	var weapon_instance = weapon_scene.instantiate()
	
	add_child(weapon_instance)
	# Passamos o Metal para a arma antes de adicioná-la à cena
	#if weapon_instance is WeaponBase:
		#weapon_instance.metal_type = test_metal
		
