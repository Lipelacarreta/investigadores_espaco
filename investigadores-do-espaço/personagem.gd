extends TextureButton

@export var puzzle_path: NodePath
@export var custo_tempo: float = 10.0

var ja_usado: bool = false

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	var puzzle = get_node(puzzle_path)
	
	print("Botão clicado")

	if !ja_usado:
		puzzle.tempo_atual -= custo_tempo
		ja_usado = true
		print("Descontou ", custo_tempo, " segundos")
	else:
		print("Já foi usado, não desconta mais")
