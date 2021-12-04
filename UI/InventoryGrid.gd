extends GridContainer

func _ready():
	GameManager.connect("player_initialised", self, "_on_player_initialised")

func _on_player_initialised(player):
	print("player_initialised")
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	
func _on_player_inventory_changed(inventory):
	for n in get_children():
		n.queue_free()
		
	for item in inventory.get_items():
		var item_label = Label.new()
		item_label.text = "%s x %d" % [item.item_reference.name, item.quantity]
		add_child(item_label)
