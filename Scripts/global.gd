extends Node

var MyIndex: int = 0
var Players = []

var inChat = false

var ChatMessage = preload("res://Scenes/ui/ingame/chat/message.tscn")
var ChatBubble = preload("res://Scenes/ui/ingame/chat/chat_bubble.tscn")

func SetPlayers(_players):
	Players = _players

func SetPlayerData(_id, _data):
	Players[_id] = _data

func AddMessage(username, msg, message_type):
	var message_copy = ChatMessage.instantiate()
	message_copy.set_data(username + ": " + msg)
	
	if message_type == Constants.MessageTypes.NearbyMessage:
		var player_node = get_tree().current_scene.get_node("YSort").get_node(str(username))
		if player_node:
			var current_bubble = player_node.get_node("Control/ChatBubble")
			
			if current_bubble:
				current_bubble.set_message(msg)
			else:
				var bubble = ChatBubble.instantiate()
				player_node.get_node("Control").add_child(bubble)
				bubble.set_message(msg)
			
	var scroll_container = get_tree().current_scene.get_node("UI/Control/MarginContainer/VBoxContainer_CHAT/ScrollContainer")
	var scrollbar = scroll_container.get_v_scroll_bar()
	
	var message_container = scroll_container.get_node("MessagesMargin/MessagesContainer")
	message_container.add_child(message_copy)
	
	if message_container.get_child_count() > 25:
		var count_to_remove = message_container.get_child_count() - 25
		for i in range(count_to_remove):
			var child = message_container.get_child(0)
			child.queue_free()  # Remove o nó da cena
			
	await get_tree().create_timer(0.1).timeout
	scroll_container.scroll_vertical = scrollbar.max_value
