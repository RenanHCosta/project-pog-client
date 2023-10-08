extends Node

var client = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI

const SERVER_ADDRESS = "127.0.0.1"
const PORT = 4242

var player = preload("res://objects/player.tscn")
var otherplayer = preload("res://objects/otherplayer.tscn")

func _ready():
	multiplayer_api = MultiplayerAPI.create_default_interface()	
	multiplayer_api.connected_to_server.connect(_connected_to_server)
	multiplayer_api.server_disconnected.connect(_server_disconnected)
	multiplayer_api.connection_failed.connect(connection_failed)

func join_server():
	
	var err = client.create_client(SERVER_ADDRESS, PORT)
	if err != OK:
		print("unable_to_connect")
		return
	client.host.compress(ENetConnection.COMPRESS_RANGE_CODER)
	get_tree().set_multiplayer(multiplayer_api, self.get_path())
	set_multiplayer_authority(1) # set server as authority
	multiplayer_api.multiplayer_peer = client
	
func connection_failed():
	get_node("/root/MainMenu/Entrar").disabled = false
	print("Connection failed")
	
func _server_disconnected():
	get_node("/root/MainMenu").show()
	print("Server disconnected")
	
func _connected_to_server():
	get_node("/root/MainMenu").hide()
	print("Connected to server")
	
@rpc("authority")
func instance_player(id, location):
	var p = player if multiplayer_api.get_unique_id() == id else otherplayer
	var player_instance = Global.instance_node(p, Nodes, location)
	player_instance.name = str(id)
	if multiplayer_api.get_unique_id() == id:
		for i in multiplayer_api.get_peers():
			if i != 1:
				instance_player(i, location)
				
				
@rpc("unreliable")
func update_transform(_direction, _position):
	pass # only executed on the server
	
@rpc("authority")
func update_player_transform(player_id, direction, position):
	if multiplayer_api.get_unique_id() != player_id:
		var player_node = Nodes.get_node(str(player_id))
		if player_node != null:
			player_node.update_transform(direction, position)
		
@rpc("authority")
func delete_obj(id):
	if Nodes.has_node(str(id)):
		Nodes.get_node(str(id)).queue_free()
