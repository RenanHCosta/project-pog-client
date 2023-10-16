extends CanvasLayer

@onready var player_name_label = %PlayerName
@onready var wait_label = %lblWait
@onready var msg_line_edit = %txtMsg

# Called when the node enters the scene tree for the first time.
func _ready():
	player_name_label.text = str(Global.Players[Global.MyIndex].username)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_T:
			if !Global.inChat:
				wait_label.visible = false
				msg_line_edit.visible = true
				get_tree().current_scene.set_process_input(true)
				Global.inChat = true
				await get_tree().create_timer(0.1).timeout
				msg_line_edit.grab_focus()
				
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_txt_msg_text_submitted(msg):
	if Global.inChat:
		if !msg.is_empty():
			ClientPackets.SendMessage.rpc_id(1, Global.MyIndex, Constants.MessageTypes.NearbyMessage, msg)
			msg_line_edit.text = ""
			
		msg_line_edit.release_focus()
		msg_line_edit.visible = false
		wait_label.visible = true
		Global.inChat = false
		get_tree().current_scene.set_process_input(false)
		
