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
	
	var scroll_container = get_node("UI/Control/MarginContainer/VBoxContainer_CHAT/ScrollContainer")
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
	
