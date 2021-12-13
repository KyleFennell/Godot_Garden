extends Resource
class_name Inventory

signal inventory_changed

export var items = [
	null, null, null, null, 
	null, null, null, null, 
	null, null, null, null, 
	null, null, null, null, 
	null, null, null, null
] setget set_items, get_items

func set_items(new_items):
	items = new_items
	emit_signal("inventory_changed", self)
	
func get_items():
	return items

func add_item(item_name, _quantity, position):
	print("adding item", item_name)
	if position == null:
		for index in range(items.size()):
			if items[index] == null:
				items[index] = ItemDatabase.get_item(item_name)
				emit_signal("inventory_changed", [index])
				return
		print("item lost", item_name)
		return
	if items[position] == null:
		var item = ItemDatabase.get_item(item_name)
		items[position] = item
		emit_signal("inventory_changed", [position])
		return
	print("item lost", item_name)

func swap_items(pos1, pos2):
	var aux = items[pos1]
	items[pos1] = items[pos2]
	items[pos2] = aux
	emit_signal("inventory_changed", [pos1, pos2])

func remove_item(pos):
	var previous_item = items[pos]
	items[pos] = null
	emit_signal("inventory_changed", [pos])
	return previous_item
