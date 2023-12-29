extends Node2D

@onready
var road = self.get_node("road")

@onready
var menu = self.get_node("menu")

const OBSTACLE_PATH = "res://scenes/obstacles/obstacle.tscn"
const MAIN_SCENE = "res://scenes/game_scenes/main_scene/scene.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func generate_enemy(y_position=null):
    var position = road.generate_random_road_position()
    if y_position:
        position.y = y_position
    var new_obstacle = preload(OBSTACLE_PATH).instantiate()
    new_obstacle.position = position
    add_child(new_obstacle)
    print("sup")
    Global.increase_scene_speed(Global.scene_acceleration)
    
    
func _input(event):
    """ Handle game pausing """
    if event.is_action_pressed("pause"):
        pause_game(Global.GAME_STATES.GAME_PAUSED_STATE)

func pause_game(state: Global.GAME_STATES):
    """ Pause the game """
    Global.game_state = state
    get_tree().set_pause(true)
    menu.set_visible(true)

func resume_game():
    """ Resume the game """
    get_tree().set_pause(false)
    menu.set_visible(false)

func restart_game():
    """ Restart the game """
    get_tree().set_pause(false)
    # CHANGING TO THIS SCENE WASN'T WORKING DUR TO USAGE OF preload ON GLOBAL SCOPE !!!!!!
    Global.restart_settings()
    get_tree().change_scene_to_file(MAIN_SCENE)
    
func handle_death():
    """ Handle player death logic, currently loading game-over menu """
    pause_game(Global.GAME_STATES.GAME_OVER_STATE)
    menu.set_visibility()

func quit_game():
    """ Quit the game """
    get_tree().quit()


func _on_menu_game_over():
    quit_game()


func _on_menu_resume_game():
    resume_game()


func _on_menu_restart_game():
    restart_game()


func _on_node_2d_player_died():
    handle_death()
