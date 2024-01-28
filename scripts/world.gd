extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.game_first_loading:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_graveyard_posx
		$player.position.y = global.player_exit_graveyard_posy
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_graveyard_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


#func _on_graveyard_transition_point_body_exited(body):# this cannot happen when you go into the other scene can not go back.It is for safety???
	#if body.has_method("player"):
		#global.transition_scene = false
		
		
func change_scene():
	if global.transition_scene:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/graveyard.tscn")
			global.game_first_loading = false
			global.finish_changescene()
