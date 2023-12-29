extends Node2D

@onready
var score: int = 0:
    get = get_score, set = increase_score
    
func get_score():
    return score
    
func increase_score(score_addition):
    score += score_addition * score_multiplier

@onready
var score_multiplier: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_timer_timeout():
    increase_score(1)
    print("score: " + str(get_score()))
