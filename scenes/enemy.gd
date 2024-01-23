extends CharacterBody2D

var speed = 30
var player_chase = false
var player = null

func _ready():
	$AnimationEnemy.play("idle")

func _physics_process(delta):
	if player_chase:
		position +=(player.position - position)/speed
		$AnimationEnemy.play('walk')
		#move_and_slide()
		if (player.position.x - position.x) < 0:
			$AnimationEnemy.flip_h = true
		else:
			$AnimationEnemy.flip_h = false
	else:
		$AnimationEnemy.play('idle')

func _on_detection_area_body_entered(body):
	#$AnimationEnemy.play("walk") 
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false



