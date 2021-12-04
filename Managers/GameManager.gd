extends Node

signal player_initialised

var player

func _process(delta):
	if not player:
		initialise_player()
		return
		
func initialise_player():
	player = get_tree().get_root().get_node("/root/MainScene/UI")
	if not player:
		return
	
	emit_signal("player_initialised", player)
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	player.inventory.add_item("Basic Plant", 5)

func _on_player_inventory_changed(inventory):
	print("inventory changed")
	pass
