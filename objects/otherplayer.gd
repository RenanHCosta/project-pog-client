extends CharacterBody2D

var player_dir = Vector2()
var player_position = Vector2()

func _physics_process(_delta):
	pass

func update_transform(_dir, _pos):
	player_dir = _dir
	player_position = _pos
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", player_position, 0.05)
