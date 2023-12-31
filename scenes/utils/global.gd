extends Node

const MIN_SCENE_SPEED = 2
const MAX_IDLE_SPEED = 6
const MIN_IDLE_SPEED = 4
const MAX_SCENE_SPEED = 8
const BALANCE_SPEED = 0.02
const SPURT_SPEED_MULTIPLIER = 2
const GRIND_SCENE_SPEED = 4
const SCENE_DECELERATION = -0.05

var scene_speed_placeholder = 0
var scene_speed = 2
var scene_acceleration = 0.5
var acceleration = 2
var enemy_cooldown = 0.5

enum GAME_STATES {GAME_RUNS_STATE, GAME_PAUSED_STATE, GAME_OVER_STATE}
var game_state = GAME_STATES.GAME_RUNS_STATE


func set_temporary_speed(temp_speed):
    """ Set a temporary speed and save old speed """
    if scene_speed_placeholder:
        push_warning("scene speed already changed")
        return
    scene_speed_placeholder = scene_speed
    scene_speed = temp_speed
    
func restore_speed():
    """ Restore speed to scene_speed_placeholder """
    if not scene_speed_placeholder:
        push_warning("scene former speed not saved")
        return
    scene_speed = scene_speed_placeholder
    scene_speed_placeholder = 0
    

func increase_scene_speed(increment: float = 0.0):
    """ Increase / Decrease scene speed, while staying at the speed's range """
    if increment > 0:
        scene_speed = move_toward(scene_speed, MAX_SCENE_SPEED, increment)
    elif increment < 0:
        scene_speed = move_toward(scene_speed, MIN_SCENE_SPEED, abs(increment))  
    print("in " + str(increment))
    print("ao " + str(scene_speed))      

func balance_speed():
    """ Balance scene_speed to be above the minimum speed and above the maximum speed """
    if scene_speed < MIN_IDLE_SPEED:
        scene_speed = move_toward(scene_speed, MIN_IDLE_SPEED, BALANCE_SPEED)
    
    if scene_speed > MAX_IDLE_SPEED:
        scene_speed = move_toward(scene_speed, MAX_IDLE_SPEED, BALANCE_SPEED)

func restart_settings():
    scene_speed = 2
    scene_acceleration = 0.5
    acceleration = 2
    enemy_cooldown = 0.5
    game_state = GAME_STATES.GAME_RUNS_STATE
