extends Node

# CONTAINS FUNCTIONS RELATIVE TO CLIENT PACKETS
# FUNCTIONS THAT CLIENT SENDS TO THE SERVER

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())

@rpc
func TryCreateAccount(username: String, password: String):
	pass # only executed on the server

@rpc("unreliable")
func update_transform(_direction, _position):
	pass # only executed on the server

@rpc
func ping():
	pass # only executed on the server
