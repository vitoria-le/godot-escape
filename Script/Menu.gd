extends Control

func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
		
		
		
func on_button_pressed(button: Button) -> void:
	match button.name:
		"btn_jogar":
			var _game: bool = get_tree().change_scene("res://scanes/Level_01.tscn")
			
		"btn_site":
			var _open_channel: bool = OS.shell_open("https://www.linkedin.com/in/leticia-vitória-batista-lima-444a71254")
			
		"btn_sair":
			get_tree().quit()
			

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = .5
				
		"entered":
			button.modulate.a = 1.0
