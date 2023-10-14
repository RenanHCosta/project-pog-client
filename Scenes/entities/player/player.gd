extends CharacterBody2D

var state_machine

var speed: float = 64.0

var friction: float = 0.2
var acceleration: float = 0.2

var my_direction: Vector2

@export var animation_tree: AnimationTree = null

func _ready() -> void:
	state_machine = animation_tree["parameters/playback"]

func _physics_process(_delta):
	_animate()
	_move()
	move_and_slide()
	
func _move_other(_direction, _velocity) -> void:
	if _direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = _direction
		animation_tree["parameters/walk/blend_position"] = _direction
		
	velocity = _velocity

func _move() -> void:
	if !self.name == Global.Players[Global.MyIndex].username:
		return
	
	if Global.inChat:
		my_direction = Vector2.ZERO
		velocity = my_direction.normalized() * speed
		return
		
	my_direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if my_direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = my_direction
		animation_tree["parameters/walk/blend_position"] = my_direction
		
		velocity.x = lerp(velocity.x, my_direction.normalized().x * speed, acceleration)
		velocity.y = lerp(velocity.y, my_direction.normalized().y * speed, acceleration)
		return
	
	velocity.x = lerp(velocity.x, my_direction.normalized().x * speed, friction)
	velocity.y = lerp(velocity.y, my_direction.normalized().y * speed, friction)
	
	velocity = my_direction.normalized() * speed

func _animate() -> void:
	if velocity.length() > 10:
		state_machine.travel("walk")
		return
	
	state_machine.travel("idle")
	
func _input(_event):
	if Global.inChat:
		return
		
func _on_timer_timeout():
	if self.name == Global.Players[Global.MyIndex].username:
		my_direction = Vector2(
			Input.get_axis("move_left", "move_right"),
			Input.get_axis("move_up", "move_down")
		)
		ClientPackets.MovementInfo.rpc_id(1, Global.MyIndex, self.name, my_direction, velocity, global_position)

func _on_renamed():
	$Control/PlayerName.text = self.name
	if self.name == Global.Players[Global.MyIndex].username:
		$Camera.enabled = true
