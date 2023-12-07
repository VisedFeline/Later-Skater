extends CharacterBody2D

@onready
var jumper = self.get_node("jumper")

var X_SPEED = 2
var Y_SPEED = 2
const LOWER_SPEED_LIMIT = 2
const UPPER_SPEED_LIMIT = 8
const ACCELERATION = 2
const IDLE_DECELERATION = 4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	print(X_SPEED)
	var horizontal_direction = Input.get_axis("left", "right")
	if horizontal_direction:
		position.x  += X_SPEED * horizontal_direction
		if X_SPEED < UPPER_SPEED_LIMIT:
			X_SPEED = move_toward(abs(X_SPEED), UPPER_SPEED_LIMIT,
			ACCELERATION * delta )
	else:
		X_SPEED = move_toward(X_SPEED, LOWER_SPEED_LIMIT, IDLE_DECELERATION * delta)
	
	var vertical_direction = Input.get_axis("up", "down")
	if vertical_direction:
		position.y  += Y_SPEED * vertical_direction
		
	if Input.is_action_pressed("accelerate"):
		Global.scene_speed = Global.scene_speed + Global.acceleration * delta
		# print(Global.scene_speed)
	
	# If things don't work, comment and FIGURE IT OUT!
	move_and_slide()
	

func die():
	print("shiiiiiiii")
