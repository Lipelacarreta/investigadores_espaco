extends TextureButton

@export var popup: Window

func _pressed():
	print("clicou fechar")

	if popup:
		popup.hide()
	else:
		print("popup NULL")
