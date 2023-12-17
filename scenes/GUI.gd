extends CanvasLayer

signal resume_game
signal restart_game
signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_button_pressed():
	""" Emit the game_over signal """
	game_over.emit()


func _on_resume_button_pressed():
	""" Emit the resume_game signal """
	resume_game.emit()


func _on_restart_button_pressed():
	""" Emit the restart_game signal """
	restart_game.emit()
	
func set_visibility():
	if Global.game_state == Global.GAME_STATES.GAME_PAUSED_STATE:
		self.get_node("Control/VBoxContainer/ResumeButton").set_visible(true)
	else:
		self.get_node("Control/VBoxContainer/ResumeButton").set_visible(false)
	self.set_visible(true)
	
	
