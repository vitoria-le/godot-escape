extends KinematicBody2D

# Velocidade de movimento do personagem
var speed = 200
var velocity = Vector2()
var is_alive = true  # Flag para verificar se o jogador está vivo


onready var animated_sprite = $AnimatedSprite

# Função principal que roda a cada frame
func _process(delta):
	if is_alive:  # Verifica se o jogador está vivo
		# Zera a velocidade a cada frame
		velocity = Vector2()

		# Controles de movimento
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1  # Move para a direita
			animated_sprite.play("walk_r")  # Toca a animação de andar para a direita
			animated_sprite.flip_h = false  # Não vira horizontalmente

		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 1  # Move para a esquerda
			animated_sprite.play("walk_r")  # Usa a mesma animação, mas com flip
			animated_sprite.flip_h = true  # Vira horizontalmente para a esquerda

		elif Input.is_action_pressed("ui_down"):
			velocity.y += 1  # Move para baixo
			animated_sprite.play("walk_f")  # Usa a animação de caminhar ou outra

		elif Input.is_action_pressed("ui_up"):
			velocity.y -= 1  # Move para cima
			animated_sprite.play("walk_b")  # Usa a animação de caminhar ou outra

		else:
			# Se nenhuma tecla for pressionada, para a animação
			animated_sprite.play("idle")

		# Normaliza o vetor de velocidade para garantir movimento constante em todas as direções
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed

		# Move o personagem usando a física de KinematicBody2D
		move_and_slide(velocity)
	else:
		# Se o jogador está morto, toca a animação de morte
		animated_sprite.play("dead_f")  # Usa a animação de morte
		# Não se move se o jogador estiver morto
		velocity = Vector2()  # Garante que a velocidade seja zerada

# Função para lidar com dano ao jogador
func take_damage(damage):
	if is_alive:  # Apenas se o jogador estiver vivo
		die()  # Chama a função de morte diretamente


	# Função para lidar com a morte do jogador
func die():
	is_alive = false  # Marca o jogador como morto
	animated_sprite.play("dead_f")  # Troca para a animação de morte


	# Atraso antes de reiniciar a cena
	yield(get_tree().create_timer(1.5), "timeout")  # Aguarda 1 segundo
	get_tree().change_scene("res://scanes/GameOver.tscn") #
	
	

