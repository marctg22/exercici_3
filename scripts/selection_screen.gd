extends Control


@export var panel_container: PanelContainer
@export var player_scene: PackedScene


func spaw_player(character_type: String)->void:
	var stats:= load("res://resources/%s.tres" % character_type) as CharacterStats
	var player := player_scene.instantiate() as Player
	player.load_stats(stats)
	panel_container.add_child(player)
	queue_free()
 
