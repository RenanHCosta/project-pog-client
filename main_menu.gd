extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$btnLogin.pressed.connect(self._login_pressed)
	$btnNewAccount.pressed.connect(self._new_account_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _login_pressed():
	Network.join_server()
	
func _new_account_pressed():
	var username = $txtUsername.text
	var password = $txtPassword.text
	ClientPackets.TryCreateAccount.rpc_id(1, username, password)
