extends Node2D

@onready
var road = self.get_node("road")

var obstacle = preload("res://obstacle.tscn")

@onready
var enemy_cooldown_timer = self.get_node("enemy_cooldown_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_cooldown_timer.wait_time = Global.enemy_cooldown
	enemy_cooldown_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_cooldown_timer_timeout():
	var obstalce_position = road.generate_random_road_position()
	var new_obstacle = obstacle.instantiate()
	new_obstacle.position = obstalce_position
	add_child(new_obstacle)
	print("sup")
	enemy_cooldown_timer.start()
