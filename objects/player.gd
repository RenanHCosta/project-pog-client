extends CharacterBody2D

var state_machine

var speed: float = 64.0

var friction: float = 0.2
var acceleration: float = 0.2

@export var animation_tree: AnimationTree = null

func _ready() -> void:
	state_machine = animation_tree["parameters/playback"]
	
func _physics_process(_delta):
	_move()
	_animate()
	move_and_slide()

func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = _direction
		animation_tree["parameters/walk/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * speed, acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * speed, acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * speed, friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * speed, friction)
	
	velocity = _direction.normalized() * speed

func _animate() -> void:
	if velocity.length() > 10:
		state_machine.travel("walk")
		return
	
	state_machine.travel("idle")
	
func _on_timer_timeout():
	pass
#	ClientPackets.update_transform.rpc_id(1, Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"), global_position)
	
