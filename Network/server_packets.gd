extends Node

# CONTAINS FUNCTIONS RELATIVE TO SERVER PACKETS
# FUNCTIONS THAT CLIENT RECEIVES FROM SERVER

var player = preload("res://objects/player.tscn")
var otherplayer = preload("res://objects/otherplayer.tscn")

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())

@rpc
func ProcessMovement(username, direction, velocity):
	Nodes.get_node(str(username))._move_other(direction, velocity)

@rpc
func PlayerDataPacket(player_index, player_data):
	if player_index < 0 or player_index > Constants.MAX_PLAYERS:
		return

	Global.SetPlayerData(player_index, player_data)
	
	# TODO: ver se o node desse player ja ta instanciado
	var p = player
	var player_instance = Global.instance_node(p, Nodes, Vector2(105, 105))
	player_instance.name = Global.Players[player_index].username
	
@rpc
func SyncPlayers(players):
	Global.SetPlayers(players)
	
	for i in range(Global.Players.size()):
		if Global.Players[i] != null:
			var p = player
			var player_instance = Global.instance_node(p, Nodes, Vector2(100, 100))
			player_instance.name = Global.Players[i].username
	
	get_node("/root/MainMenu").hide()

@rpc("authority")
func LoginOk(index):
	Global.MyIndex = index
	
@rpc("authority")
func AlertMsg(msg):
	get_tree().current_scene.get_node("popupAlert").get_node("lblAlertMsg").text = msg
	get_tree().current_scene.get_node("popupAlert").visible = true
	
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
func delete_obj(username):
	if Nodes.has_node(str(username)):
		Nodes.get_node(str(username)).queue_free()
