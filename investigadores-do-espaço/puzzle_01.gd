extends Node2D

@export var tempo_inicial:int = 60

var tempo_atual:float
var acabou = false

func _ready():
	tempo_atual = tempo_inicial

func _process(delta):

	if acabou:
		return

	tempo_atual -= delta
	print(int(tempo_atual))

	if tempo_atual <= 0:
		tempo_atual = 0
		game_over()

func game_over():
	acabou = true
	print("GAME OVER")
