extends CenterContainer

var inventory = preload("res://UI/Inventory/Inventory.tres")	

func display_item(item: Item):
	if item:
		$ItemTextureRect.texture = item.texture
	else:
		$ItemTextureRect.texture = null

func get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.items[item_index]
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		data.fail_callback = {"func": funcref(inventory, "add_item"), "args": [item.name, null, item_index]}
		var drag_preview = TextureRect.new()
		drag_preview.texture = item.texture
		set_drag_preview(drag_preview)
		DragDropManager.dropData = data
		inventory.remove_item(item_index)
		return data
	pass

func can_drop_data(_position, data):
	return data is Dictionary and data.has("Item")
	pass
	
func drop_data(_position, data):
	var item_index = get_index()
	var item = inventory.items[item_index]
	inventory.swap_items(item_index, data.item_index)
	inventory.set_item(item_index, data.item)
	pass
