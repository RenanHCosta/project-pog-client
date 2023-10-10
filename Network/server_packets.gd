extends Node

# CONTAINS FUNCTIONS RELATIVE TO SERVER PACKETS
# FUNCTIONS THAT CLIENT RECEIVES FROM SERVER

var player = preload("res://objects/player.tscn")
var otherplayer = preload("res://objects/otherplayer.tscn")

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())
	
@rpc("authority")
func instance_player(id, location):
	var p = player if Network.multiplayer_api.get_unique_id() == id else otherplayer
	var player_instance = Global.instance_node(p, Nodes, location)
	player_instance.name = str(id)
	if Network.multiplayer_api.get_unique_id() == id:
		for i in Network.multiplayer_api.get_peers():
			if i != 1:
				instance_player(i, location)

@rpc("authority")
func update_player_transform(player_id, direction, position):
	if Network.multiplayer_api.get_unique_id() != player_id:
		var player_node = Nodes.get_node(str(player_id))
		if player_node != null:
			player_node.update_transform(direction, position)

@rpc("authority")
func delete_obj(id):
	if Nodes.has_node(str(id)):
		Nodes.get_node(str(id)).queue_free()
