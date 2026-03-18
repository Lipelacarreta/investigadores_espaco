extends Node2D

@export var tempo_inicial: float = 60.0
@export var tempo_label: Label

@export var dica01: TextureButton
@export var dica02: TextureButton
@export var dica03: TextureButton

# 🔧 valores configuráveis no Inspector
@export var custo_dica01: float = 10.0
@export var custo_dica02: float = 10.0
@export var custo_dica03: float = 10.0

var tempo_atual: float
var acabou: bool = false

# estado das dicas
var dica_a_usada = false
var dica_b_usada = false
var dica_c_usada = false

func _ready():
	tempo_atual = tempo_inicial
	
	# UI do tempo
	tempo_label.add_theme_font_size_override("font_size", 80)
	tempo_label.add_theme_color_override("font_color", Color.WHITE)
	tempo_label.add_theme_color_override("font_outline_color", Color.BLACK)
	tempo_label.add_theme_constant_override("outline_size", 5)
	
	# trava dicas iniciais
	dica02.disabled = true
	dica03.disabled = true

	# conecta sinais
	dica01.pressed.connect(_on_dica01_pressed)
	dica02.pressed.connect(_on_dica02_pressed)
	dica03.pressed.connect(_on_dica03_pressed)

func _process(delta):
	if acabou:
		return

	tempo_atual -= delta
	tempo_label.text = formatar_tempo(tempo_atual)

	if tempo_atual <= 16:
		tempo_label.modulate = Color(1, 0.2, 0.2)
	else:
		tempo_label.modulate = Color(1, 1, 1)

	if tempo_atual <= 0:
		tempo_atual = 0
		tempo_label.text = "00:00"
		game_over()

func game_over():
	acabou = true
	print("GAME OVER")

func formatar_tempo(t):
	var segundos = int(t) % 60
	var minutos = int(t) / 60
	return "%02d:%02d" % [minutos, segundos]

# --------------------
# DICAS
# --------------------

func _on_dica01_pressed():
	print("Clicou Dica01")
	
	if !dica_a_usada:
		tempo_atual -= custo_dica01
		dica_a_usada = true
		dica02.disabled = false
		print("Dica02 LIBERADA | -", custo_dica01, "s")

func _on_dica02_pressed():
	print("Clicou Dica02")
	
	if !dica_b_usada:
		tempo_atual -= custo_dica02
		dica_b_usada = true
		dica03.disabled = false
		print("Dica03 LIBERADA | -", custo_dica02, "s")

func _on_dica03_pressed():
	print("Clicou Dica03")
	
	if !dica_c_usada:
		tempo_atual -= custo_dica03
		dica_c_usada = true
		print("Dica03 usada | -", custo_dica03, "s")
