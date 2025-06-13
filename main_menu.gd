# MainMenu.gd
extends Control

func _ready():
	# Connect the button's "pressed" signal to a function
	$Button.pressed.connect(_on_Button_pressed)
	# Connect the FileDialog's "file_selected" signal to a function
	$FileDialog.file_selected.connect(_on_FileDialog_file_selected)

func _on_Button_pressed():
	# Show the file dialog when the button is pressed
	$FileDialog.popup_centered()

func _on_FileDialog_file_selected(path):
	# When a file is selected, store the path in a global script
	# and switch to the game scene.
	Global.image_path = path
	get_tree().change_scene_to_file("res://Game.tscn")
