extends CharacterBody3D

var SPEED = 2.0
const JUMP_VELOCITY = 4.5

func update_sprite(direction: Vector3) -> void:
	#if direction.x != 0 and direction.y != 0 and direction.z != 0:
	#print(direction)
	# TODO: MAKE NOT SUCK!!!! This code will not work properly if the player rotation is different at all!
	#       look into using an AnimationTree?
	#       also looks horrific if you turn the camera because the sprite does not change
	if direction.x > 0 and direction.z > 0:
		$Sprite.play("walk_se")
		return # i dont *care* if its better for readability, you do not need return spam in godot
	if direction.x < 0 and direction.z < 0:
		$Sprite.play("walk_nw")
		return
	if direction.x > 0 and direction.z < 0:
		$Sprite.play("walk_ne")
		return
	if direction.x < 0 and direction.z > 0:
		$Sprite.play("walk_sw")
		return
	
	if direction.x > 0:
		$Sprite.play("walk_right")
		return
	if direction.x < 0:
		$Sprite.play("walk_left")
		return
	if direction.z > 0:
		$Sprite.play("walk_down")
		return
	if direction.z < 0:
		$Sprite.play("walk_up")
		return

func _physics_process(delta: float) -> void:
	## Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_pressed("button_2"):
		SPEED = 6.0
	else:
		SPEED = 2.0
	## Handle jump.
	if Input.is_action_just_pressed("button_1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	## Get the input direction and handle the movement/deceleration.
	# TODO: this script, while it works, sucks bad and needs to be rewritten
	# BUG: if you change the camera, the player still moves along the original axises which is BAD and we HATES it
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	update_sprite(direction)
	move_and_slide()
	
	if Input.is_action_just_pressed("temp_cam_left"):
		$Pivot.rotation -= Vector3(0,45,0)
	if Input.is_action_just_pressed("temp_cam_right"):
		$Pivot.rotation += Vector3(0,45,0)
	
	if position.y <= -10: ## dont fall out of the world dumbass
		get_tree().reload_current_scene() 

func _on_sprite_animation_finished() -> void:
	$Sprite.stop()
