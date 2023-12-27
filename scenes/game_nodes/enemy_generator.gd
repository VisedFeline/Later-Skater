extends Node2D

@onready
var game_manager = self.get_parent()

@onready
var skater = game_manager.get_node("skater")

@onready
var direct_obstacle_timer = self.get_node("direct_obstacle_timer")
@onready
var enemy_cooldown_timer = self.get_node("enemy_cooldown_timer")
@onready
var TIMERS = [direct_obstacle_timer, enemy_cooldown_timer]

# First element is 'from' float, second is 'to' gloat
const RANDOM_DIRECT_ENEMY_GENERATION_RANGE = [2, 4]
const RANDOM_OBSTACLE_GENERATION_RANGE = 1


# Called when the node enters the scene tree for the first time.
func _ready():
    for timer in TIMERS:
        timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_direct_obstacle_timer_timeout():
    var obstacle_y_position = skater.position.y
    game_manager.generate_enemy(obstacle_y_position)
    var new_wait_time = randf_range(RANDOM_DIRECT_ENEMY_GENERATION_RANGE[0],
                                    RANDOM_DIRECT_ENEMY_GENERATION_RANGE[1])
    direct_obstacle_timer.set_wait_time(new_wait_time)
    print("dwt: " + str(direct_obstacle_timer.get_wait_time()))


func _on_enemy_cooldown_timer_timeout():
    game_manager.generate_enemy()
    var new_wait_time = randf_range(0, RANDOM_OBSTACLE_GENERATION_RANGE)
    enemy_cooldown_timer.set_wait_time(new_wait_time)
    print("ewt: " + str(enemy_cooldown_timer.get_wait_time()))
    
