# Pixel.gd
extends ColorRect
# Signal to notify the game when this pixel is entered
signal pixel_entered(pixel)

var color_number: int = 0

func _ready():
	pass

func _gui_input(event):
	if event is InputEventMouseMotion:
		emit_signal("pixel_entered", self)
