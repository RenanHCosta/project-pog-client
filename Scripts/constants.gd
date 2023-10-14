extends Node

const MAX_PLAYERS = 15

# Network Initialize Settings
const SERVER_ADDRESS = "127.0.0.1"
const PORT = 4242

enum MessageTypes {
	WorldMessage = 1,
	NearbyMessage
}
