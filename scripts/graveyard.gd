extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_graveyard_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		
func change_scene():
	if global.transition_scene:
		if global.current_scene == "graveyard":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finish_changescene()
