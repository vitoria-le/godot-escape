extends KinematicBody2D

var speed = 100  # Velocidade do inimigo
var player: KinematicBody2D = null  # Referência ao jogador
var path: Array = []
var navigation_path: Navigation2D = null
var velocity = Vector2()

# Variáveis de ataque
var attack_radius = 60  # Raio de ataque
var attack_damage = 10  # Dano causado ao jogador
var player_attacked = false  # Flag para verificar se o jogador foi atacado

onready var animated_sprite = $AnimatedSprite1
onready var monstrodie = $monstrodie as AudioStreamPlayer



func _ready():
	yield(get_tree(), "idle_frame")
	player = get_parent().get_node("Player")
	navigation_path = get_parent().get_node("pathfinding")
	print(player)
	
	

func _physics_process(delta: float) -> void:
	if !Engine.editor_hint:
		if player and navigation_path:
			generate_path()
			navigate()
			if !player_attacked:  # Verifica se o jogador ainda não foi atacado
				move(delta)  # Passar delta para a função move
				attack_player()  # Verifica se pode atacar
			update_animation()

func move(delta):
	# Tenta mover o inimigo em direção ao jogador
	if path.size() > 0:
		velocity = (path[0] - global_position).normalized() * speed
		# Mover o inimigo
		global_position += velocity * delta  # Usar delta para movimento suave
	else:
		velocity = Vector2.ZERO  # Se não houver caminho, pare o movimento

func generate_path():
	if player != null and navigation_path != null:
		path = navigation_path.get_simple_path(global_position, player.global_position, false)
		print(path)  # Verificar os pontos do caminho

func navigate():
	if path.size() > 0:
		if global_position.distance_to(path[0]) < 5:  # Verifica se o inimigo está próximo o suficiente do ponto
			path.pop_front()

func update_animation():
	if player_attacked:  # Se o jogador foi atacado, não atualiza a animação de movimento
		return

	if velocity.length() > 0:
		if velocity.x > 0:
			animated_sprite.play("walk_r")
			animated_sprite.flip_h = false
		elif velocity.x < 0:
			animated_sprite.play("walk_r")
			animated_sprite.flip_h = true
		elif velocity.y > 0:
			animated_sprite.play("walk_f")
		elif velocity.y < 0:
			animated_sprite.play("walk_b")
	else:
		animated_sprite.play("idle")  # Para animação de idle se não está se movendo
		

func attack_player():
	if is_on_area_of_effect(player):  # Verifica se o jogador está na área de ataque
			player.take_damage(attack_damage)  # Chama a função take_damage no jogador
			player_attacked = true  # Marca que o jogador foi atacado
			animated_sprite.play("atack_f")  # Troca para a animação de ataque (se existir)
			monstrodie.play()	

			
func is_on_area_of_effect(target: KinematicBody2D) -> bool:
	return global_position.distance_to(target.global_position) <= attack_radius
