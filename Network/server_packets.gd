extends Node

# CONTAINS FUNCTIONS RELATIVE TO SERVER PACKETS
# FUNCTIONS THAT CLIENT RECEIVES FROM SERVER

var player = preload("res://Scenes/entities/player/player.tscn")
var WorldMap = preload("res://Scenes/maps/world_map.tscn")

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())

@rpc
func ChatMessage(username, msg, message_type):
	Global.AddMessage(username, msg, message_type)

@rpc
func ProcessAttack(username, is_attacking):
	var player_node = get_tree().current_scene.get_node("YSort").get_node(str(username))
	if player_node:	
		get_tree().current_scene.get_node("YSort").get_node(str(username))._attack(is_attacking)
	
@rpc
func ProcessMovement(username, direction, velocity, position):
	var player_container = get_tree().current_scene.get_node("YSort")

	if !player_container:
		return
		
	var player_node = player_container.get_node(str(username))
	if player_node:
		player_node._move_other(direction, velocity, position)

@rpc
func PlayerDataPacket(player_index, player_data):
	if player_index < 0 or player_index > Constants.MAX_PLAYERS:
		return

	Global.SetPlayerData(player_index, player_data)
	
	# TODO: ver se o node desse player ja ta instanciado
	get_tree().current_scene.instance_player(player, Global.Players[player_index].username, Vector2(Global.Players[player_index].location.x, Global.Players[player_index].location.y))

@rpc("authority")
func LoginOk(index, players):
	Global.MyIndex = index
	Global.SetPlayers(players)	
	
	get_tree().change_scene_to_packed(WorldMap)
	
@rpc("authority")
func AlertMsg(msg):
	get_tree().current_scene.get_node("popupAlert").get_node("lblAlertMsg").text = msg
	get_tree().current_scene.get_node("popupAlert").visible = true

@rpc("authority")
func update_player_transform(player_id, direction, position):
	if Network.multiplayer_api.get_unique_id() != player_id:
		var player_node = WorldMap.get_node(str(player_id))
		if player_node != null:
			player_node.update_transform(direction, position)

@rpc("authority")
func delete_obj(username):
	if WorldMap.has_node(str(username)):
		WorldMap.get_node(str(username)).queue_free()
