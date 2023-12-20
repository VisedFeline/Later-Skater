extends CharacterBody2D

@onready
var air_collision = self.get_node("air_collision")

@onready
var parent = self.get_parent()

@onready
var center = parent.get_node("center")

const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var time = 0


func setup_jump_collision(is_jumping: bool):
    """ Setup the node's collision layers so that obstacles can't touch it midair but can while on ground """
    self.set_collision_layer_value(8, is_jumping)
    self.set_collision_layer_value(4, !is_jumping)
    
    

func _physics_process(delta):
    # Add the gravity.
    if is_jumping:
        # position.x  += X_SPEED * horizontal_direction
        #if X_SPEED < UPPER_SPEED_LIMIT:
        #    X_SPEED = move_toward(abs(X_SPEED), UPPER_SPEED_LIMIT,
        #    ACCELERATION * delta )
        if velocity.y < 0:
            # move up
            velocity.y = move_toward(velocity.y, 0, gravity * delta)
        elif velocity.y != -JUMP_VELOCITY:
            # move down
            velocity.y = move_toward(velocity.y, -JUMP_VELOCITY, gravity * delta)
        
        else:
        #velocity.y += gravity * delta
        #if velocity.y >= JUMP_VELOCITY * -1:
            print(velocity.y)
            velocity.y = 0
            is_jumping = false
            self.position = center.position
            setup_jump_collision(is_jumping)

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and not is_jumping:
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        setup_jump_collision(is_jumping)
        # For some reason, when collision layer is set to one everything's bad at jumping, but 2 works,
        # FIGURE IT OUT
        air_collision.set_disabled(false)
        

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.s

    
    move_and_slide()
    
    
func die():
    parent.die()

func hop():
    print("Wiiiiiiiiiiiiii")
