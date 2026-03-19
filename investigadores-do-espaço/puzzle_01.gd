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
@export var popup_game_over: Window

@export var textura_usado: Texture2D

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
	
	# UI tempo
	if tempo_label:
		tempo_label.add_theme_font_size_override("font_size", 80)
		tempo_label.add_theme_color_override("font_color", Color.WHITE)
		tempo_label.add_theme_color_override("font_outline_color", Color.BLACK)
		tempo_label.add_theme_constant_override("outline_size", 5)

	# personagens ativos
	if personagem01: personagem01.disabled = false
	if personagem02: personagem02.disabled = false
	if personagem03: personagem03.disabled = false
	if personagem04: personagem04.disabled = false

	# dicas progressivas
	if dica01: dica01.disabled = false
	if dica02: dica02.disabled = true
	if dica03: dica03.disabled = true

	# 🔥 CONFIGURA TODOS OS POPUPS CORRETAMENTE
	configurar_popup(popup01)
	configurar_popup(popup02)
	configurar_popup(popup03)
	configurar_popup(popup04)
	configurar_popup(popup_game_over)

	# 🔥 GARANTE QUE GAME OVER NÃO APARECE NO INÍCIO
	if popup_game_over:
		popup_game_over.visible = false
		popup_game_over.hide()

	# conectar botões
	if personagem01: personagem01.pressed.connect(_on_p1)
	if personagem02: personagem02.pressed.connect(_on_p2)
	if personagem03: personagem03.pressed.connect(_on_p3)
	if personagem04: personagem04.pressed.connect(_on_p4)

	if dica01: dica01.pressed.connect(_on_dica01)
	if dica02: dica02.pressed.connect(_on_dica02)
	if dica03: dica03.pressed.connect(_on_dica03)

# 🔥 FUNÇÃO CORRIGIDA PRA WINDOW
func configurar_popup(popup: Window):
	if popup:
		popup.visible = false
		popup.hide()
		popup.borderless = true
		popup.unresizable = true
		popup.size = get_viewport_rect().size
		popup.position = Vector2.ZERO
		
		popup.close_requested.connect(func(): popup.hide())

func _process(delta):
	if acabou:
		return

	tempo_atual -= delta
	
	if tempo_label:
		tempo_label.text = formatar_tempo(tempo_atual)

	if tempo_atual <= 16 and tempo_label:
		tempo_label.modulate = Color(1, 0.2, 0.2)
	else:
		if tempo_label:
			tempo_label.modulate = Color(1, 1, 1)

	if tempo_atual <= 0:
		tempo_atual = 0
		if tempo_label:
			tempo_label.text = "00:00"
		game_over()

func game_over():
	acabou = true
	print("GAME OVER")

	if popup_game_over:
		popup_game_over.popup()

func formatar_tempo(t):
	var segundos = int(t) % 60
	var minutos = int(t) / 60
	return "%02d:%02d" % [minutos, segundos]

# --------------------
# PERSONAGENS
# --------------------

func _on_p1():
	if !usado01:
		tempo_atual -= custo01
		usado01 = true
		if textura_usado and personagem01:
			personagem01.texture_normal = textura_usado
	
	if popup01:
		popup01.popup()

func _on_p2():
	if !usado02:
		tempo_atual -= custo02
		usado02 = true
		if textura_usado and personagem02:
			personagem02.texture_normal = textura_usado
	
	if popup02:
		popup02.popup()

func _on_p3():
	if !usado03:
		tempo_atual -= custo03
		usado03 = true
		if textura_usado and personagem03:
			personagem03.texture_normal = textura_usado
	
	if popup03:
		popup03.popup()

func _on_p4():
	if !usado04:
		tempo_atual -= custo04
		usado04 = true
		if textura_usado and personagem04:
			personagem04.texture_normal = textura_usado
	
	if popup04:
		popup04.popup()

# --------------------
# DICAS
# --------------------

func _on_dica01():
	if !dica_a_usada:
		tempo_atual -= custo_dica01
		dica_a_usada = true
		if dica02:
			dica02.disabled = false

func _on_dica02():
	if !dica_b_usada:
		tempo_atual -= custo_dica02
		dica_b_usada = true
		if dica03:
			dica03.disabled = false

func _on_dica03():
	if !dica_c_usada:
		tempo_atual -= custo_dica03
		dica_c_usada = true
