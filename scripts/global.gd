extends Node

var player_current_attack = false

var current_scene = "world" #world,graveyard
var transition_scene = false

var player_exit_graveyard_posx = 102
var player_exit_graveyard_posy = 20
var player_start_posx = 14
var player_start_posy = 102
var game_first_loading = true

func finish_changescene():
	if transition_scene:
		transition_scene = false
		if current_scene == "world":
			current_scene = "graveyard"
		else:
			current_scene = "world"
