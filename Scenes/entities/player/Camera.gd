extends Camera2D

# Set the minimum and maximum zoom levels
var min_zoom = 0.5
var max_zoom = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize the zoom level
	zoom = Vector2(1.0, 1.0)

func _input(event):
	if event is InputEventMouseButton:
		# Handle mouse wheel input for zooming
		if event.is_action("zoom_in"):
			zoom_in()
		elif event.is_action("zoom_out"):
			zoom_out()
			
func zoom_in():
	# Increase the zoom level, but ensure it stays within bounds
	zoom = clamp(zoom + Vector2(0.1, 0.1), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

func zoom_out():
	# Decrease the zoom level, but ensure it stays within bounds
	zoom = clamp(zoom - Vector2(0.1, 0.1), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
