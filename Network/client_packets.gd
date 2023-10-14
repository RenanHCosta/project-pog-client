extends Node

# CONTAINS FUNCTIONS RELATIVE TO CLIENT PACKETS
# FUNCTIONS THAT CLIENT SENDS TO THE SERVER

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())

@rpc 
func SendMessage(_player_index, _message_type: Constants.MessageTypes, msg: String):
	pass # only executed on the server

@rpc
func Logout(_index):
	pass # only executed on the server
	
@rpc 
func MovementInfo(_index, _username, _direction, _velocity, _position):
	pass # only executed on the server
	
@rpc
func TryCreateAccount(_username: String, _password: String):
	pass # only executed on the server
	
@rpc
func TryLogin(_username: String, _password: String):
	pass # only executed on the Server

@rpc("unreliable")
func update_transform(_direction, _position):
	pass # only executed on the server

@rpc
func ping():
	pass # only executed on the server
