extends Button

func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	Network.join_server()
