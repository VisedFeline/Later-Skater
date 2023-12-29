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

@onready
var air_collision = self.get_node("air_collision")

const JUMP_VELOCITY = -400.0

var is_jumping = false


func setup_jump_collision(is_jumping: bool):
    self.set_collision_layer_value(8, !is_jumping)
    self.set_collision_layer_value(4, is_jumping)


signal player_died


func handle_jump():
    """ Handle jump mechanism, add velocity and change collision layers """
    velocity.y = JUMP_VELOCITY
    is_jumping = true
    setup_jump_collision(is_jumping)
    # For some reason, when collision layer is set to one everything's bad at jumping, but 2 works,
    # FIGURE IT OUT
    print(air_collision.name)
    air_collision.set_disabled(false)

func _physics_process(delta):
    if is_jumping:
        velocity.y += gravity * delta
        if velocity.y >= JUMP_VELOCITY * -1:
            velocity.y = 0
            is_jumping = false
            setup_jump_collision(is_jumping)
            
    if Input.is_action_just_pressed("jump") and not is_jumping:
        handle_jump()
    
    
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
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
    #move_and_slide()
    

func die():
    player_died.emit()
