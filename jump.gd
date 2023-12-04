extends CharacterBody2D

@onready
var air_collision = self.get_node("air_collision")

const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false


func _physics_process(delta):
	# Add the gravity.
	if is_jumping:
		velocity.y += gravity * delta
		if velocity.y >= JUMP_VELOCITY * -1:
			velocity.y = 0
			is_jumping = false
			air_collision.set_disabled(true)

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and not is_jumping:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		# For some reason, when collision layer is set to one everything's bad at jumping, but 2 works,
		# FIGURE IT OUT
		air_collision.set_disabled(false)
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.s

	
	move_and_slide()
