extends Node2D

@onready
var road = self.get_node("road")

@onready
var menu = self.get_node("menu")

const OBSTACLE_PATH = "res://obstacle.tscn"

@onready
var enemy_cooldown_timer = self.get_node("enemy_cooldown_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("dofuck")
	enemy_cooldown_timer.wait_time = Global.enemy_cooldown
	enemy_cooldown_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_cooldown_timer_timeout():
	var obstalce_position = road.generate_random_road_position()
	var new_obstacle = preload(OBSTACLE_PATH).instantiate()
	new_obstacle.position = obstalce_position
	add_child(new_obstacle)
	print("sup")
	enemy_cooldown_timer.start()
	Global.scene_speed += Global.scene_acceleration
	
	
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
	get_tree().change_scene_to_file("res://scene.tscn")
	
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
