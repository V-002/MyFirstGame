extends CharacterBody3D

@export var speed: int = 14
@export var jump_impulse: int = 20
@export var bounce_impulse: int = 15
@export var fall_acceleration: float = 50

var target_velocity: Vector3 = Vector3.ZERO

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
func _physics_process(delta):
	var direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		direction.z += -1
	if Input.is_action_pressed("back"):
		direction.z += 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x += -1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		# Basis basis represent the transform of $Pivot
		$Pivot.basis = Basis.looking_at(direction)
	
	# set the player's velocity by scaling the direction vector by speed
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	for index in range(get_slide_collision_count()):
		
		var collision = get_slide_collision(index)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			# UP(0,1,0).NORMAL tells you whether you hit on top or bellow
			# -.1 < x <.1 for front/side -.1 > x for bellow and >.1 for top
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
				break
		
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	#jump
	
		
	velocity = target_velocity	
	move_and_slide()
