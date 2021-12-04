extends Node
class_name Inventory

signal inventory_changed

export var _items = Array() setget set_items, get_items

func set_items(new_items):
	_items = new_items
	emit_signal("inventory_changed", self)
	
func get_items():
	return _items
	
func get_item(index):
	return _items[index]
	
func add_item(item_name, quantity):
	print("adding items",item_name, quantity)
	if quantity <= 0:
		print("Cannot add negative quantity of items")
		return
		
	var item = ItemDatabase.get_item(item_name)
	if not item:
		print("Cannot find item: %s" % item_name)
		return
	
	var items_remaining = true
	for i in range(_items.size()):
		if _items[i].item_reference.name != item.name:
			continue
		
		_items[i].quantity += quantity
		items_remaining = false
	
	if items_remaining:
		_items.append({
			item_reference = item,
			quantity = quantity
		})
	emit_signal("inventory_changed", self)
	print(_items)
