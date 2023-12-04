extends CharacterBody2D

const SPEED = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction = Input.get_axis("left", "right")
	if horizontal_direction:
		position.x  += SPEED * horizontal_direction
	
	var vertical_direction = Input.get_axis("up", "down")
	if vertical_direction:
		position.y  += SPEED * vertical_direction
		
	if Input.is_action_pressed("accelerate"):
		Global.scene_speed = Global.scene_speed + Global.acceleration * delta
		# print(Global.scene_speed)
	
	# If things don't work, comment and FIGURE IT OUT!
	move_and_slide()
