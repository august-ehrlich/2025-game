# Game.gd
extends Control

# Preload the Pixel scene
const Pixel = preload("res://Pixel.tscn")

# The color palette. The index of the color corresponds to the color_number.
const COLOR_PALETTE = [
	Color.WHITE,    # 0 - Background
	Color.BLACK,    # 1
	Color.RED,      # 2
	Color.GREEN,    # 3
	Color.BLUE      # 4
]

var selected_color_index: int = 1

func _ready():
	# This is where you would call your Python script.
	# For now, we'll use a mock function.
	var pixel_data = generate_mock_pixel_data(Global.image_path)
	generate_pixel_grid(pixel_data)
	setup_color_palette()

# MOCK FUNCTION: Replace this with your Python script's output
func generate_mock_pixel_data(image_path: String) -> Array[Array]:
	# In your final version, you would use your Python package to analyze
	# the image at 'image_path' and return a 2D array of color numbers.
	# For now, we'll return a hardcoded 5x5 grid.
	print("Generating mock pixel data for: ", image_path)
	return [
		[1, 1, 1, 1, 1],
		[1, 2, 3, 4, 1],
		[1, 3, 0, 2, 1],
		[1, 4, 2, 3, 1],
		[1, 1, 1, 1, 1]
	]

func generate_pixel_grid(data: Array[Array]):
	# Set the number of columns for the GridContainer
	$GridContainer.columns = data[0].size()

	for y in range(data.size()):
		for x in range(data[y].size()):
			var pixel_instance = Pixel.instantiate()
			pixel_instance.color_number = data[y][x]
			# Set the initial color of the pixel based on its number
			pixel_instance.color = Color.DIM_GRAY
			# Connect the pixel's clicked signal
			pixel_instance.pixel_entered.connect(_on_pixel_entered)
			$GridContainer.add_child(pixel_instance)

func setup_color_palette():
	for i in range(1, COLOR_PALETTE.size()): # Start from 1 to skip background
		var color_rect = ColorRect.new()
		color_rect.color = COLOR_PALETTE[i]
		color_rect.custom_minimum_size = Vector2(32, 32)
		# Add an input event to the color rect to make it clickable
		color_rect.gui_input.connect(func(event):
			if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				selected_color_index = i
				print("Selected color: ", i)
		)
		$HBoxContainer.add_child(color_rect)

func _on_pixel_entered(pixel):
	if pixel.color_number == selected_color_index:
		pixel.color = COLOR_PALETTE[selected_color_index]
