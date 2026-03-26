extends Node2D

@export var tempo_inicial: float = 60.0

# custos (ajusta no inspector)
@export var custo_dica01: float = 5.0
@export var custo_dica02: float = 5.0
@export var custo_dica03: float = 5.0

@export var custo_invent_ga10: float = 5.0
@export var custo_invent_astro: float = 5.0
@export var custo_invent_gala: float = 5.0
@export var custo_invent_otelo: float = 5.0

# custos alternativas
@export var custo_altern_a: float = 5.0
@export var custo_altern_b: float = 5.0
@export var custo_altern_c: float = 5.0

var tempo_atual: float

@onready var tempo_label: Label = $tempo
@onready var gameover: CanvasLayer = $gameover

# botões de dica
@onready var dica01_btn: TextureButton = $dicas/dica01_btn
@onready var dica02_btn: TextureButton = $dicas/dica02_btn
@onready var dica03_btn: TextureButton = $dicas/dica03_btn

# botões de inventário
@onready var invent_ga10_btn: TextureButton = $inventarios/invent_ga10_btn
@onready var invent_astro_btn: TextureButton = $inventarios/invent_astro_btn
@onready var invent_gala_btn: TextureButton = $inventarios/invent_gala_btn
@onready var invent_otelo_btn: TextureButton = $inventarios/invent_otelo_btn

# botões alternativas
@onready var altern_a_btn: TextureButton = $alternativas/altern_a_btn
@onready var altern_b_btn: TextureButton = $alternativas/altern_b_btn
@onready var altern_c_btn: TextureButton = $alternativas/altern_c_btn

var paused:bool = false

func _ready():
	tempo_atual = tempo_inicial
	gameover.visible = false

	dica02_btn.disabled = true
	dica03_btn.disabled = true

func _process(delta):
	if (paused):
		return
		
	tempo_atual -= delta

	if tempo_atual <= 0:
		tempo_atual = 0
		gameover.visible = true

	tempo_label.text = formatar_tempo(tempo_atual)

	if tempo_atual <= 10:
		tempo_label.modulate = Color(1, 0, 0)
	else:
		tempo_label.modulate = Color(1, 1, 1)

func formatar_tempo(t):
	var segundos = int(t) % 60
	@warning_ignore("integer_division")
	var minutos = int(t) / 60
	return "%02d:%02d" % [minutos, segundos]

# --------------------
# UTIL
# --------------------

func gastar_tempo(valor: float):
	tempo_atual = max(tempo_atual - valor, 0)

func fechar_tudo():
	$dicas/dica01.visible = false
	$dicas/dica02.visible = false
	$dicas/dica03.visible = false

	$inventarios/invent_ga10.visible = false
	$inventarios/invent_astro.visible = false
	$inventarios/invent_gala.visible = false
	$inventarios/invent_otelo.visible = false

	$alternativas/altern_a.visible = false
	$alternativas/altern_b.visible = false
	$alternativas/altern_c.visible = false

	gameover.visible = false

# --------------------
# INVENTÁRIO
# --------------------

func _on_invent_ga_10_btn_pressed() -> void:
	paused = true
	$inventarios/invent_ga10.visible = true
	if invent_ga10_btn.texture_normal != invent_ga10_btn.texture_pressed:
		gastar_tempo(custo_invent_ga10)
		invent_ga10_btn.texture_normal = invent_ga10_btn.texture_pressed

func _on_invent_astro_btn_pressed() -> void:
	paused = true
	$inventarios/invent_astro.visible = true
	if invent_astro_btn.texture_normal != invent_astro_btn.texture_pressed:
		gastar_tempo(custo_invent_astro)
		invent_astro_btn.texture_normal = invent_astro_btn.texture_pressed

func _on_invent_gala_btn_pressed() -> void:
	paused = true
	$inventarios/invent_gala.visible = true
	if invent_gala_btn.texture_normal != invent_gala_btn.texture_pressed:
		gastar_tempo(custo_invent_gala)
		invent_gala_btn.texture_normal = invent_gala_btn.texture_pressed

func _on_invent_otelo_btn_pressed() -> void:
	paused = true
	$inventarios/invent_otelo.visible = true
	if invent_otelo_btn.texture_normal != invent_otelo_btn.texture_pressed:
		gastar_tempo(custo_invent_otelo)
		invent_otelo_btn.texture_normal = invent_otelo_btn.texture_pressed

# --------------------
# DICAS
# --------------------

func _on_dica_01_btn_pressed() -> void:
	paused = true
	$dicas/dica01.visible = true
	if dica01_btn.texture_normal != dica01_btn.texture_pressed:
		gastar_tempo(custo_dica01)
		dica01_btn.texture_normal = dica01_btn.texture_pressed
	dica02_btn.disabled = false

func _on_dica_02_btn_pressed() -> void:
	paused = true
	$dicas/dica02.visible = true
	if dica02_btn.texture_normal != dica02_btn.texture_pressed:
		gastar_tempo(custo_dica02)
		dica02_btn.texture_normal = dica02_btn.texture_pressed
	dica03_btn.disabled = false

func _on_dica_03_btn_pressed() -> void:
	paused = true
	$dicas/dica03.visible = true
	if dica03_btn.texture_normal != dica03_btn.texture_pressed:
		gastar_tempo(custo_dica03)
		dica03_btn.texture_normal = dica03_btn.texture_pressed

# --------------------
# ALTERNATIVAS
# --------------------

func _on_altern_a_btn_pressed() -> void:
	paused = true
	$alternativas/altern_a.visible = true
	if altern_a_btn.texture_normal != altern_a_btn.texture_pressed:
		gastar_tempo(custo_altern_a)
		altern_a_btn.texture_normal = altern_a_btn.texture_pressed

func _on_altern_b_btn_pressed() -> void:
	paused = true
	$alternativas/altern_b.visible = true
	if altern_b_btn.texture_normal != altern_b_btn.texture_pressed:
		gastar_tempo(custo_altern_b)
		altern_b_btn.texture_normal = altern_b_btn.texture_pressed

func _on_altern_c_btn_pressed() -> void:
	paused = true
	$alternativas/altern_c.visible = true
	if altern_c_btn.texture_normal != altern_c_btn.texture_pressed:
		gastar_tempo(custo_altern_c)
		altern_c_btn.texture_normal = altern_c_btn.texture_pressed

# --------------------
# FECHAR
# --------------------

func _on_resume_btn_pressed() -> void:
	paused = false
	fechar_tudo()

# --------------------
# REINICIAR
# --------------------

func _on_reiniciar_btn_pressed() -> void:
	get_tree().reload_current_scene()
