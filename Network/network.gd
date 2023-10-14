extends Node

var client = ENetMultiplayerPeer.new()
var multiplayer_api : MultiplayerAPI

var player = preload("res://Scenes/entities/player/player.tscn")

func _ready():
	multiplayer_api = MultiplayerAPI.create_default_interface()	
	multiplayer_api.connected_to_server.connect(_connected_to_server)
	multiplayer_api.server_disconnected.connect(_server_disconnected)
	multiplayer_api.connection_failed.connect(connection_failed)
	
	var err = client.create_client(Constants.SERVER_ADDRESS, Constants.PORT)
	if err != OK:
		print("unable_to_connect")
		return
		
	client.host.compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	ClientPackets.start()
	ServerPackets.start()
	
	set_multiplayer_authority(1)
	multiplayer_api.multiplayer_peer = client
	
func connection_failed():
#	get_node("/root/MainMenu/Entrar").disabled = false
	print("Connection failed")
	
func _server_disconnected():
#	get_node("/root/MainMenu").show()
	print("Server disconnected")
	
func _connected_to_server():
#	get_node("/root/MainMenu").hide()
	print("Connected to server")
