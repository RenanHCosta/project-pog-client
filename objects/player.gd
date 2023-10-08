extends CharacterBody2D

var speed = 250  # speed in pixels/sec

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed

	move_and_slide()


func _on_timer_timeout():
	Server.update_transform.rpc_id(1, Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"), global_position)
	
