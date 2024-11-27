extends Node2D  # Ou outro tipo de nó, conforme o seu jogo

onready var canvas_modulate = $CanvasModulate  # Assumindo que o CanvasModulate está no nó principal

# Função para alterar a cor do ambiente para vermelho
func change_environment_color_to_red():
	canvas_modulate.modulate = Color(1, 0, 0)  # Altera a cor para vermelho
