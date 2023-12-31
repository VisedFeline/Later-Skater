extends AnimatedSprite2D

var skater = null
var STATES = null
var STATE_TO_ANIMATION = null



# Called when the node enters the scene tree for the first time.
func _ready():
    skater = self.get_parent().get_parent()
    STATES = skater.SKATER_STATES
    STATE_TO_ANIMATION = {
    STATES.STANDING: "idle",
    STATES.CROUCHING: "crouch",
    STATES.JUMPING: "jump",
    STATES.GRINDING: "grind",
    STATES.SPEEDING: "idle",
    STATES.SLOWING: "slow",
    STATES.FALLEN: "fall",
    }


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    self.play(STATE_TO_ANIMATION[skater.skater_state])


func _on_skater_player_died():
    self.play(STATE_TO_ANIMATION[STATES.FALLEN])
