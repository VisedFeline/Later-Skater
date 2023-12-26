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


func _on_enemy_cooldown_timer_timeout():
    game_manager.generate_enemy()
