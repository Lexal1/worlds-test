extends CharacterBody3D

var SPEED = 2.0
const JUMP_VELOCITY = 4.5

func update_sprite(direction: Vector3) -> void:
	#if direction.x != 0 and direction.y != 0 and direction.z != 0:
	#print(direction)
	# this code fails miserably if the player rotation isn't 0
	#TODO: MAKE NOT SUCK!!!! This code will not work properly if the camera or the player rotation are different at all!
	#      look into using an AnimationTree?
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
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_pressed("button_2"):
		SPEED = 6.0
	else:
		SPEED = 2.0
	# Handle jump.
	if Input.is_action_just_pressed("button_1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# TODO: this script, while it works, sucks bad and needs to be rewritten
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

func _on_sprite_animation_finished() -> void:
	$Sprite.stop()
