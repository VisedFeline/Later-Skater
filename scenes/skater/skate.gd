extends CharacterBody2D

enum SKATER_STATES {STANDING, CROUCHING, JUMPING, GRINDING, SPEEDING, SLOWING}
var skater_state = SKATER_STATES.STANDING

# STANDING PARAMS
const Y_SPEED_STANDING_MULTIPLIER = 1
const BACKWARD_SPEED_MULTIPLIER = 7

# CROUCHING PARAMS
const Y_SPEED_CROUCH_MULTIPLIER = 1.5

# JUMPING PARAMS


@onready
var slowdown_timer = get_node("slowing_down_timer")

@onready
var jumper = self.get_node("jumper")

var x_speed = 2
var y_speed = 2
var y_speed_multiplier = Y_SPEED_STANDING_MULTIPLIER
const LOWER_SPEED_LIMIT = 1
const UPPER_SPEED_LIMIT = 8
const ACCELERATION = 2
const GRIND_ACCELERATION = 0.2
const IDLE_DECELERATION = 4
const SLOWDOWN_TIMEOUT = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_died

func grind(delta):
    """ Handle grind movement """
    x_speed += GRIND_ACCELERATION * delta
    position.x  += x_speed

func enter_standing_state():
    y_speed_multiplier = Y_SPEED_STANDING_MULTIPLIER
    self.skater_state = SKATER_STATES.STANDING
    
func handle_slowdown_timer():
    """ Start slowdown timer if plyer slows down, reset it if not """
    if self.skater_state == SKATER_STATES.SLOWING:
        if slowdown_timer.is_stopped():
            print("momofofo")
            slowdown_timer.start(SLOWDOWN_TIMEOUT)
    else:
        print("mofo")
        slowdown_timer.stop()

func handle_states(delta):
    """ Handle state by input """
    var should_enter_stainding = (not Input.is_action_pressed("crouch") 
                                  and not Input.is_action_pressed("accelerate")
                                  and not Input.is_action_pressed("left"))
    if Input.is_action_pressed("left"):
        self.skater_state = SKATER_STATES.SLOWING
    elif Input.is_action_pressed("crouch"):
        self.skater_state = SKATER_STATES.CROUCHING
        y_speed_multiplier = Y_SPEED_CROUCH_MULTIPLIER
    elif Input.is_action_pressed("accelerate"):
        self.skater_state = SKATER_STATES.SPEEDING
        Global.increase_scene_speed(Global.acceleration * delta)
    elif should_enter_stainding:
        enter_standing_state()
    print("staate: " + str(self.skater_state))

func move_vertically():
    """ Handle vertical movement logic """
    var vertical_direction = Input.get_axis("up", "down")
    var is_grinding = skater_state == SKATER_STATES.GRINDING
    if vertical_direction and not is_grinding:
        position.y  += y_speed * vertical_direction * y_speed_multiplier

func handle_scene_speed():
    if self.skater_state == SKATER_STATES.STANDING:
        Global.balance_speed()

func _physics_process(delta):
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    handle_states(delta)
    handle_scene_speed()
    handle_slowdown_timer()
    
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
            if horizontal_direction < 0:
                self.skater_state = SKATER_STATES.SLOWING
                handle_slowdown_timer()
                x_speed = move_toward(abs(x_speed), LOWER_SPEED_LIMIT,
                BACKWARD_SPEED_MULTIPLIER * delta )
                Global.increase_scene_speed(Global.SCENE_DECELERATION)
        else:
            x_speed = move_toward(x_speed, LOWER_SPEED_LIMIT, IDLE_DECELERATION * delta)
    
        #var vertical_direction = Input.get_axis("up", "down")
        #if vertical_direction:
        #    position.y  += y_speed * vertical_direction * y_speed_multiplier
        move_vertically()
        
    if Input.is_action_pressed("accelerate"):
        Global.increase_scene_speed(Global.acceleration * delta)
        self.skater_state = SKATER_STATES.SPEEDING
        # Global.scene_speed = Global.scene_speed + Global.acceleration * delta
        # print(Global.scene_speed)
    elif self.skater_state == SKATER_STATES.SPEEDING:
        self.skater_state = SKATER_STATES.STANDING
    
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


func _on_slowing_down_timer_timeout():
    player_died.emit()
