extends CharacterBody2D

enum SKATER_STATES {STANDING, CROUCHING, JUMPING, GRINDING}
var skater_state = SKATER_STATES.STANDING

# STANDING PARAMS
const Y_SPEED_STANDING_MULTIPLIER = 1

# CROUCHING PARAMS
const Y_SPEED_CROUCH_MULTIPLIER = 1.5

# JUMPING PARAMS


@onready
var jumper = self.get_node("jumper")

var x_speed = 2
var y_speed = 2
var y_speed_multiplier = Y_SPEED_STANDING_MULTIPLIER
const LOWER_SPEED_LIMIT = 2
const UPPER_SPEED_LIMIT = 8
const ACCELERATION = 2
const GRIND_ACCELERATION = 0.2
const IDLE_DECELERATION = 4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_died

func grind(delta):
    """ Handle grind movement """
    x_speed += GRIND_ACCELERATION * delta
    position.x  += x_speed


func handle_states():
    """ Handle state by input """
    if Input.is_action_pressed("crouch"):
        skater_state = SKATER_STATES.CROUCHING
        y_speed_multiplier = Y_SPEED_CROUCH_MULTIPLIER
    else:
        skater_state = SKATER_STATES.STANDING
        y_speed_multiplier = Y_SPEED_STANDING_MULTIPLIER


func move_horizontally():
    """ Handle horizontal movement logic """
    var vertical_direction = Input.get_axis("up", "down")
    var is_grinding = skater_state == SKATER_STATES.GRINDING
    if vertical_direction and not is_grinding:
        position.y  += y_speed * vertical_direction * y_speed_multiplier


func _physics_process(delta):
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    handle_states()
    
    var horizontal_direction = Input.get_axis("left", "right")
    
    if jumper.is_grinding:
        grind(delta)
        print("x_speed")
        print(x_speed)
    else:
        if horizontal_direction:
            position.x  += x_speed * horizontal_direction
            if x_speed < UPPER_SPEED_LIMIT:
                x_speed = move_toward(abs(x_speed), UPPER_SPEED_LIMIT,
                ACCELERATION * delta )
        else:
            x_speed = move_toward(x_speed, LOWER_SPEED_LIMIT, IDLE_DECELERATION * delta)
    
        var vertical_direction = Input.get_axis("up", "down")
        if vertical_direction:
            position.y  += y_speed * vertical_direction * y_speed_multiplier
        
    if Input.is_action_pressed("accelerate"):
        Global.increase_scene_speed(Global.acceleration * delta)
        # Global.scene_speed = Global.scene_speed + Global.acceleration * delta
        # print(Global.scene_speed)
    
    # If things don't work, comment and FIGURE IT OUT!
    move_and_slide()
    

func stop_grind():
    """ Handle stop grind behaviors """
    Global.restore_speed()
    #var speed_incement = Global.scene_speed * GRIND_ACCELERATION - Global.scene_speed
    #print("sp " + str(speed_incement))
    Global.increase_scene_speed(Global.scene_speed * GRIND_ACCELERATION)
    
    #Global.scene_speed += (Global.scene_speed * GRIND_ACCELERATION)

func die():
    player_died.emit()
