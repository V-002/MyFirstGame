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
	
	var player_position = $Player.position
	mob.initialise(mob_spawn_location.position, player_position)
	
	# Spawn the mob by adding it to the main scene
	add_child(mob)
