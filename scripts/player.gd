extends CharacterBody2D

const speed = 100
var current_dir = "none"
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip =false #ip = in progress

func _ready():
	$AnimationPlayer.play("front_idle")
func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	if health <= 0:
		player_alive = false
		health = 0 
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		play_anim(1)
		current_dir = "right"
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim(1)
		current_dir = "left"
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		play_anim(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimationPlayer
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if !attack_ip:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if !attack_ip:
				anim.play("side_idle")
	if dir == "down":
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if !attack_ip:
				anim.play("front_idle")
	if dir == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if !attack_ip:
				anim.play("back_idle")


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func player():
	pass
	
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		health -= 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimationPlayer.flip_h = false
			$AnimationPlayer.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimationPlayer.flip_h = true
			$AnimationPlayer.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimationPlayer.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimationPlayer.play("back_attack")
			$deal_attack_timer.start()
		
		


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	
func current_camera():
	if global.current_scene == "world":
		$Camera2D.enabled = true
		$Camera_graveyard.enabled = false
	elif global.current_scene == "graveyard":
		$Camera2D.enabled = false
		$Camera_graveyard.enabled = true


func update_health():
	$healthbar.value = health
	#if health >= 100:
		#$healthbar.visible = false
	#else:
		#$healthbar.visible = true
		
func _on_regenation_timer_timeout():
	if health < 100:
		health += 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
		

	
	
