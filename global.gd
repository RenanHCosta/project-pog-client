extends Node

var MyIndex: int = 0
var Players = []

func instance_node(node: PackedScene, parent, location):
	var node_instance = node.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	node_instance.global_position = location
	parent.add_child(node_instance)
	return node_instance

func SetPlayers(_players):
	Players = _players

func SetPlayerData(_id, _data):
	Players[_id] = _data
