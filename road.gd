extends Sprite2D

@onready
var top_positon_node = self.get_node("top_generation_position")
@onready
var bottom_positon_node = self.get_node("bottom_generation_position")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func generate_random_road_position() -> Vector2:
	"""
	Generate a random position on the road, between the y position of the top and bottom positions,
	the x is of both positions (since it's the same).
	"""
	var x_position = top_positon_node.position.x
	var top_y_position = top_positon_node.position.y
	var bottom_y_position = bottom_positon_node.position.y
	var rng = RandomNumberGenerator.new()
	var random_y_position = rng.randf_range(bottom_y_position, top_y_position)
	# DEBUG: print("{} {}".format([top_y_position, bottom_y_position], "{}"))
	return Vector2(x_position, random_y_position)
