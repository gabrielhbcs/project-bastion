extends CharacterBody2D

@export var velocidade = 40.0
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direcao = Vector2.ZERO

	if Input.is_key_pressed(KEY_W):
		direcao.y -= 1
	if Input.is_key_pressed(KEY_S):
		direcao.y += 1
	if Input.is_key_pressed(KEY_A):
		direcao.x -= 1
	if Input.is_key_pressed(KEY_D):
		direcao.x += 1
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		direcao = mouse_pos - global_position
	
	if direcao.x < 0:
		sprite.flip_h = true
	if direcao.x > 0:
		sprite.flip_h = false

	velocity = direcao.normalized() * velocidade
	
	move_and_slide()
	# Essa velocidade real é o vetor pós colisões, então
	# se tiver batendo na parede, a velocidade real é 0
	var velocidade_real = get_real_velocity()
	
	if velocidade_real != Vector2.ZERO:
		sprite.play("walk")
	else:
		sprite.play("idle")
