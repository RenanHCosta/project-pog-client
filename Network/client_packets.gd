extends Node

# CONTAINS FUNCTIONS RELATIVE TO CLIENT PACKETS
# FUNCTIONS THAT CLIENT SENDS TO THE SERVER

func start():
	get_tree().set_multiplayer(Network.multiplayer_api, self.get_path())
	
@rpc("unreliable")
func update_transform(_direction, _position):
	pass # only executed on the server

@rpc
func ping():
	pass # only executed on the server
