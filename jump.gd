extends CharacterBody2D

@onready
var air_collision = self.get_node("air_collision")

@onready
var parent = self.get_parent()

@onready
var center = parent.get_node("center")

const JUMP_VELOCITY = -400.0
const GRIND_JUMP_MULTIPLIER = 1.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_grinding = false
var time = 0


func setup_jump_collision(is_jumping: bool):
    """ Setup the node's collision layers so that obstacles can't touch it midair but can while on ground """
    self.set_collision_layer_value(8, is_jumping)
    self.set_collision_layer_value(4, !is_jumping)
    
    
func handle_grind():
    """ Handle grind movement """
    is_jumping = false
    


func _physics_process(delta):
    var is_node_above_center = self.position.y < center.position.y
    
    # Add the gravity.
    if is_jumping:        
        # Move up until gravity stops velocity
        if velocity.y < 0:
            velocity.y = move_toward(velocity.y, 0, gravity * delta)
            
        # move down until max velocity reached (reaching ground again from peak)
        # or until the jumper node is below the skater node
        elif is_node_above_center:
            velocity.y = velocity.y + gravity * delta # move_toward(velocity.y, abs(JUMP_VELOCITY), gravity * delta)
        
        # else reset node position and velocity
        else:
            velocity.y = 0
            is_jumping = false
            self.position = center.position
            setup_jump_collision(is_jumping)
            

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and not is_jumping:
        velocity.y = JUMP_VELOCITY
        if is_grinding:
            velocity.y *= GRIND_JUMP_MULTIPLIER
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

func grind(position):
    """ Initiate rad grinding dawg """
    var should_grind = Input.is_action_pressed("grind")
    if not should_grind:
        return
    var new_position = Vector2(self.position.x, position.y)
    var new_velocity = Vector2(self.velocity.x, 0)
    self.set_position(new_position)
    self.set_velocity(new_velocity)
    is_grinding = true
    is_jumping = false

func stop_grind():
    if not is_grinding:
        return
    is_grinding = false
    is_jumping = true
    parent.stop_grind()
