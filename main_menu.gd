extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$input_wrapper.get_node("btnLogin").pressed.connect(self._login_pressed)
	$input_wrapper.get_node("btnNewAccount").pressed.connect(self._new_account_pressed)
	$popupAlert.get_node("btnAlertOk").pressed.connect(self._alert_ok_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _login_pressed():
	var username = $input_wrapper.get_node("txtUsername").text
	var password = $input_wrapper.get_node("txtPassword").text
	ClientPackets.TryLogin.rpc_id(1, username, password)
	
func _new_account_pressed():
	var username = $input_wrapper.get_node("txtUsername").text
	var password = $input_wrapper.get_node("txtPassword").text
	ClientPackets.TryCreateAccount.rpc_id(1, username, password)

func _alert_ok_pressed():
	$popupAlert.visible = false
