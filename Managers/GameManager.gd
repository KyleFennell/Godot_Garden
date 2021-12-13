extends Node

signal ui_initialised

var ui

func _process(delta):
	if not ui:
		initialise_ui()
		return
		
func initialise_ui():
	ui = get_tree().get_root().get_node("/root/MainScene/UI")
	if not ui:
		return
	
	emit_signal("ui_initialised", ui)
	ui.inventory.connect("inventory_changed", self, "_on_ui_inventory_changed")

func _on_ui_inventory_changed(inventory):
	print("inventory changed")
	pass
