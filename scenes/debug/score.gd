extends Label

@onready
var scorer = get_tree().root.get_node("level").get_node("skater").get_node("scorer")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    self.text = "SCORE: " + "%.3f" % scorer.score
