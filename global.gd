extends Node

const SPURT_SPEED_MULTIPLIER = 2

var scene_speed_placeholder = 0
var scene_speed = 2
var scene_acceleration = 0.5
var acceleration = 2
var enemy_cooldown = 0.5

enum GAME_STATES {GAME_RUNS_STATE, GAME_PAUSED_STATE, GAME_OVER_STATE}
var game_state = GAME_STATES.GAME_RUNS_STATE


func set_temporary_speed():
    """ Set a temporary speed and save old speed """
    if scene_speed_placeholder:
        push_warning("scene speed already changed")
        return
    scene_speed_placeholder = scene_speed
    scene_speed *= SPURT_SPEED_MULTIPLIER
    
func restore_speed():
    """ Restore speed to scene_speed_placeholder """
    if not scene_speed_placeholder:
        push_warning("scene former speed not saved")
        return
    scene_speed = scene_speed_placeholder
    scene_speed_placeholder = 0

func restart_settings():
    scene_speed = 2
    scene_acceleration = 0.5
    acceleration = 2
    enemy_cooldown = 0.5
    game_state = GAME_STATES.GAME_RUNS_STATE
