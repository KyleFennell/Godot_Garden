extends Node

var items = Array()

func _ready():
	var directory = Directory.new()
	directory.open("res://Resources/Items")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while(filename):
		if not directory.current_is_dir():
			print("added item:", filename)
			items.append(load("res://Resources/Items/%s" % filename))
		
		filename = directory.get_next()
		
func get_item(item_name):
	for i in items:
		if i.name == item_name:
			return i
	
	return null
