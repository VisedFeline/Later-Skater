extends Node

var scene_speed = 2
var scene_acceleration = 0.5
var acceleration = 2
var enemy_cooldown = 0.5

enum GAME_STATES {GAME_RUNS_STATE, GAME_PAUSED_STATE, GAME_OVER_STATE}
var game_state = GAME_STATES.GAME_RUNS_STATE


func restart_settings():
    scene_speed = 2
    scene_acceleration = 0.5
    acceleration = 2
    enemy_cooldown = 0.5
    game_state = GAME_STATES.GAME_RUNS_STATE
