extends Area2D

const SPEED = 2
const HORIZONTAL_DIRECTION = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x  += Global.scene_speed * HORIZONTAL_DIRECTION
