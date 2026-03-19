extends Control

@export var botao_fechar: TextureButton

func _ready():
	# fullscreen garantido
	set_anchors_preset(Control.PRESET_FULL_RECT)
	
	# começa escondido
	hide()
	
	# conecta botão
	if botao_fechar:
		botao_fechar.pressed.connect(_fechar)

func abrir():
	show()
	print("Popup aberto")

func _fechar():
	hide()
	print("Popup fechado")
