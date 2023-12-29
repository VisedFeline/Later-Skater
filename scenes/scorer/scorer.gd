extends Node2D

const BASE_SCORE = 1.0
const RUSH_START_MULTIPLIER = 1.0
const rush_multiplier_increase = 0.2

var rush_multiplier = RUSH_START_MULTIPLIER

@onready
var score: int = 0:
    get = get_score, set = increase_score
    
func get_score():
    return score
    
func increase_score(score_addition):
    score += score_addition * score_multiplier

@onready
var score_multiplier: float = 1

func handle_rush_multiplier():
    """ Calculate the rush multiplier based on whether the skater speed is that of rush mode """
    if Global.scene_speed > Global.MAX_IDLE_SPEED:
        rush_multiplier += rush_multiplier_increase
    else:
        rush_multiplier = RUSH_START_MULTIPLIER

func calculate_score() -> float:
    """ Calculate the score """
    return BASE_SCORE * Global.scene_speed * rush_multiplier

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    handle_rush_multiplier()


func _on_timer_timeout():
    var score_increase = calculate_score()
    increase_score(score_increase)
    print("score: " + str(get_score()))
