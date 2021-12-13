extends GridContainer

var inventory = preload("res://UI/Inventory/Inventory.tres")

func _ready():
	inventory.connect("inventory_changed", self, "_onitems_changed")
	update_inventory_display()
	inventory.add_item("Red Plant", null, null)
	inventory.add_item("Red Plant", null, null)
	inventory.add_item("Yellow Plant", null, null)
	inventory.add_item("Yellow Plant", null, null)
	pass
	
func update_inventory_display():
	for item_index in range(inventory.items.size()):
		update_inventory_slot_display(item_index)
	
func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

func _onitems_changed(indecies):
	for item_index in indecies:
		update_inventory_slot_display(item_index)
