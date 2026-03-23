extends Node2D

@export var tempo_inicial: float = 60.0
@export var tempo_label: Label

# 🎮 PERSONAGENS
@export var personagem01: TextureButton
@export var personagem02: TextureButton
@export var personagem03: TextureButton
@export var personagem04: TextureButton

# 💡 DICAS
@export var dica01: TextureButton
@export var dica02: TextureButton
@export var dica03: TextureButton

# 🪟 POPUPS
@export var popup01: Window
@export var popup02: Window
@export var popup03: Window
@export var popup04: Window
@export var popup_gameover: Window

# 🪟 POPUPS DICAS
@export var popup_dica01: Window
@export var popup_dica02: Window
@export var popup_dica03: Window

# ⏱️ custos
@export var custo01: float = 10.0
@export var custo02: float = 10.0
@export var custo03: float = 10.0
@export var custo04: float = 10.0

@export var custo_dica01: float = 10.0
@export var custo_dica02: float = 10.0
@export var custo_dica03: float = 10.0

var tempo_atual: float
var acabou: bool = false

var usado01 = false
var usado02 = false
var usado03 = false
var usado04 = false

var dica_a_usada = false
var dica_b_usada = false
var dica_c_usada = false

func _ready():
	tempo_atual = tempo_inicial

	if tempo_label:
		tempo_label.add_theme_font_size_override("font_size", 80)

	# esconder tudo
	if popup_gameover: popup_gameover.hide()

	if popup01: popup01.hide()
	if popup02: popup02.hide()
	if popup03: popup03.hide()
	if popup04: popup04.hide()

	if popup_dica01: popup_dica01.hide()
	if popup_dica02: popup_dica02.hide()
	if popup_dica03: popup_dica03.hide()

	# bloquear dicas
	if dica02: dica02.disabled = true
	if dica03: dica03.disabled = true

	# conexões
	if personagem01: personagem01.pressed.connect(_on_p1)
	if personagem02: personagem02.pressed.connect(_on_p2)
	if personagem03: personagem03.pressed.connect(_on_p3)
	if personagem04: personagem04.pressed.connect(_on_p4)

	if dica01: dica01.pressed.connect(_on_dica01)
	if dica02: dica02.pressed.connect(_on_dica02)
	if dica03: dica03.pressed.connect(_on_dica03)

func _process(delta):
	if acabou:
		return

	tempo_atual -= delta

	if tempo_label:
		tempo_label.text = formatar_tempo(tempo_atual)

	if tempo_atual <= 0:
		tempo_atual = 0
		game_over()

func game_over():
	if acabou:
		return

	acabou = true

	if popup_gameover:
		var tela = get_viewport_rect().size
		popup_gameover.size = tela
		popup_gameover.position = Vector2.ZERO
		popup_gameover.popup()

func formatar_tempo(t):
	var segundos = int(t) % 60
	var minutos = int(t) / 60
	return "%02d:%02d" % [minutos, segundos]

# --------------------
# PERSONAGENS (CORRIGIDO 🔥)
# --------------------

func _on_p1():
	if !usado01:
		tempo_atual -= custo01
		usado01 = true
		personagem01.texture_normal = personagem01.texture_pressed

	if popup01:
		var tela = get_viewport_rect().size
		popup01.size = tela
		popup01.position = Vector2.ZERO
		popup01.popup()

func _on_p2():
	if !usado02:
		tempo_atual -= custo02
		usado02 = true
		personagem02.texture_normal = personagem02.texture_pressed

	if popup02:
		var tela = get_viewport_rect().size
		popup02.size = tela
		popup02.position = Vector2.ZERO
		popup02.popup()

func _on_p3():
	if !usado03:
		tempo_atual -= custo03
		usado03 = true
		personagem03.texture_normal = personagem03.texture_pressed

	if popup03:
		var tela = get_viewport_rect().size
		popup03.size = tela
		popup03.position = Vector2.ZERO
		popup03.popup()

func _on_p4():
	if !usado04:
		tempo_atual -= custo04
		usado04 = true
		personagem04.texture_normal = personagem04.texture_pressed

	if popup04:
		var tela = get_viewport_rect().size
		popup04.size = tela
		popup04.position = Vector2.ZERO
		popup04.popup()

# --------------------
# DICAS (CORRIGIDO 🔥)
# --------------------

func _on_dica01():
	if !dica_a_usada:
		tempo_atual -= custo_dica01
		dica_a_usada = true
		dica01.texture_normal = dica01.texture_pressed

		if dica02:
			dica02.disabled = false

	if popup_dica01:
		var tela = get_viewport_rect().size
		popup_dica01.size = tela
		popup_dica01.position = Vector2.ZERO
		popup_dica01.popup()

func _on_dica02():
	if !dica_b_usada:
		tempo_atual -= custo_dica02
		dica_b_usada = true
		dica02.texture_normal = dica02.texture_pressed

		if dica03:
			dica03.disabled = false

	if popup_dica02:
		var tela = get_viewport_rect().size
		popup_dica02.size = tela
		popup_dica02.position = Vector2.ZERO
		popup_dica02.popup()

func _on_dica03():
	if !dica_c_usada:
		tempo_atual -= custo_dica03
		dica_c_usada = true
		dica03.texture_normal = dica03.texture_pressed

	if popup_dica03:
		var tela = get_viewport_rect().size
		popup_dica03.size = tela
		popup_dica03.position = Vector2.ZERO
		popup_dica03.popup()
