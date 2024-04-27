extends CharacterBody3D

@export var speed: int = 14
@export var fall_acceleration: float = 17

var target_velocity: Vector3 = Vector3.ZERO

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
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	velocity = target_velocity
	move_and_slide()
