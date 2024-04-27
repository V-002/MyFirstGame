extends Node

# asset for the mob
@export var mob_scene: PackedScene

func _on_timer_timeout():
	# instantiate the mob scene
	var mob = mob_scene.instantiate()
	# get random location inthe designated area
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	# add an offset between 0.0 and 1.0
	mob_spawn_location.progress_ratio = randf()
	
	# if left as a 3D vector mobs will point up when spawing while
	#  player is mid jump so flatten y position
	var player_position = $Player.position
	player_position.y = 0
	
	mob.initialise(mob_spawn_location.position, player_position)
	
	# Spawn the mob by adding it to the main scene
	add_child(mob)
