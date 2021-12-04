extends Node2D

var Plant = load("res://Plot/Plant.tscn")

var plant = null
var timer = 0

func _ready():
	$TopCollision.connect("clicked", self, "on_left_click")
	pass
	
func _process(delta):
	pass

func on_left_click():
	print(name, " clicked")
	add_plant(load("res://Resources/Plants/red_plant_a.tres"))

func add_plant(plant):
	$TopCollision.disabled = true
	var plant_child = Plant.instance()
	self.add_child(plant_child, true)
	plant_child.initialise(self, plant)
	plant_child.connect("tree_exited", self, "on_plant_removed")
	
func on_plant_removed():
	$TopCollision.disabled = false
