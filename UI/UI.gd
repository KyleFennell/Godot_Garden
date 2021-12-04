extends Node

var inventory_resource = load("res://UI/Inventory.gd")
var inventory = inventory_resource.new()

func _ready():
	inventory.add_item("Basic Plant", 3)
