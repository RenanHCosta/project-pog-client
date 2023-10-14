extends Node

var ChatMessage = preload("res://Scenes/ui/ingame/chat/message.tscn")
var UserInterface: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_tree_exiting():
	pass # Replace with function body.


func _on_tree_entered():
	pass # Replace with function body.

func AddMessage(msg):
	var message_copy = ChatMessage.instantiate()
	message_copy.set_data(msg)
	
	var chat_container = get_node("UI/Control/MarginContainer/VBoxContainer_CHAT/MessagesMargin/MessagesContainer")
	chat_container.add_child(message_copy)
