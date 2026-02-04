extends CharacterBody2D

@export var velocidade = 300.0
@onready var sprite = $Sprite2D

func _physics_process(_delta):
	var direcao = Vector2.ZERO

	if Input.is_key_pressed(KEY_W):
		direcao.y -= 1
	if Input.is_key_pressed(KEY_S):
		direcao.y += 1
	if Input.is_key_pressed(KEY_A):
		direcao.x -= 1
		sprite.flip_h = true
	if Input.is_key_pressed(KEY_D):
		direcao.x += 1
		sprite.flip_h = false

	velocity = direcao.normalized() * velocidade
	
	move_and_slide()
