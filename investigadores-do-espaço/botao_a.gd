extends Button

@export var resposta_certa: bool = false
@export var puzzle_path: NodePath

func _pressed():

	var puzzle = get_node(puzzle_path)

	if resposta_certa:
		print("correto")
	else:
		puzzle.tempo_atual -= 30
		print("errou -30s")
