extends Node2D

@onready
var road = self.get_node("road")

@onready
var menu = self.get_node("menu")

@onready
var current_level = preload("res://scene.tscn")

var obstacle = preload("res://obstacle.tscn")

@onready
var enemy_cooldown_timer = self.get_node("enemy_cooldown_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_cooldown_timer.wait_time = Global.enemy_cooldown
	enemy_cooldown_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("hohoho")


func _on_enemy_cooldown_timer_timeout():
	var obstalce_position = road.generate_random_road_position()
	var new_obstacle = obstacle.instantiate()
	new_obstacle.position = obstalce_position
	add_child(new_obstacle)
	print("sup")
	enemy_cooldown_timer.start()
	Global.scene_speed += Global.scene_acceleration
	
	
func _input(event):
	""" Handle game pausing """
	if event.is_action_pressed("pause"):
		var is_game_paused = get_tree().paused
		get_tree().paused = not is_game_paused
		menu.visible = not is_game_paused

func resume_game():
	""" Resume the game """
	get_tree().paused = false
	menu.visible = false

func restart_game():
	""" Restart the game """
	var root = get_tree().root
	var new_scene = current_level.instantiate()
	root.add_child(new_scene)
	root.get_children()
	root.current_screen = root.get_children()[-1]

func quit_game():
	""" Quit the game """
	get_tree().quit()


func _on_menu_game_over():
	quit_game()


func _on_menu_resume_game():
	resume_game()


func _on_menu_restart_game():
	restart_game()
