extends CharacterBody3D

@export var min_speed: int = 10
@export var max_speed: int = 18

signal squashed

func _physics_process(delta):
	move_and_slide()

func initialise(start_position: Vector3, player_position: Vector3):
	
	# places the mob at start position and looks at player position
	look_at_from_position(start_position, player_position, Vector3.UP)
	# rotate to not look straight toward player
	rotate_y(randf_range(-PI/4, PI/4))
	
	var random_speed = randi_range(min_speed, max_speed)
	
	# forward is [0,0,-1]
	velocity = Vector3.FORWARD * random_speed
	# rotate to the velocity vector to face direction of mob's forward vector
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
func squash():
	squashed.emit()
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
