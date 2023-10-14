extends Node

# CONTAINS FUNCTIONS RELATIVE TO CLIENT PACKETS
# FUNCTIONS THAT CLIENT SENDS TO THE SERVER

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())

@rpc 
func AttackInfo(_index, _username, _is_attacking):
	pass # only executed on the server
	
@rpc 
func MovementInfo(_index, _username, _direction, _velocity, _position):
	pass # only executed on the server
	
@rpc
func TryCreateAccount(username: String, password: String):
	pass # only executed on the server
	
@rpc
func TryLogin(username: String, password: String):
	pass # only executed on the Server

@rpc("unreliable")
func update_transform(_direction, _position):
	pass # only executed on the server

@rpc
func ping():
	pass # only executed on the server
