extends TextureButton

@export var popup: Window

func _pressed():
	if popup:
		popup.hide()
