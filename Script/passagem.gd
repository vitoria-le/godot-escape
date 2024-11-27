extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_passagem_body_entered(body):
	# Verifica se estamos na cena scanelv1
	if get_tree().current_scene.filename == "res://scanes/scanelv1.tscn":
		# Se estiver na scanelv1, volta para Level_01
		get_tree().change_scene("res://scanes/Level_01.tscn")
	else:
		# Caso contrário, muda para scanelv1
		get_tree().change_scene("res://scanes/scanelv1.tscn")
