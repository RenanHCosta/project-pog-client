extends Control

# Função para definir o texto da Label e atualizar o tamanho do chat bubble
func set_message(text):
	%Label.text = text
	var new_label_size = %Label.get_combined_minimum_size()
	var min_panel_size = Vector2(8, 8)  # Tamanho mínimo desejado para o painel

	if new_label_size.x > min_panel_size.x:
		min_panel_size.x = new_label_size.x
	
	%Panel.set_size(min_panel_size + Vector2(16, 0))
	
	var bubble_position = get_parent().position
	bubble_position.x = bubble_position.x - %Panel.get_size().x / 2
	bubble_position.y = -8
	%Panel.set_position(bubble_position)
	$Timer.start()


func _on_timer_timeout():
	queue_free()
