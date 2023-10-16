extends Node2D

var player = preload("res://Scenes/entities/player/player.tscn")

func instance_player(node: PackedScene, name, location):
	var node_instance = node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	node_instance.global_position = location
	node_instance.name = name
	%YSort.add_child(node_instance)
	return node_instance
	
#func get_player_instance(username: String):
#	var instance = %YSort.get_child(YSort)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tree_entered():
	for i in range(Global.Players.size()):
		if Global.Players[i] != null:
			var p = player
			var player_instance = instance_player(p, Global.Players[i].username, Vector2(Global.Players[i].location.x, Global.Players[i].location.y))
