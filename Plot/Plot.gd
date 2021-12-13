extends Node2D

var Plant = load("res://Plot/Plant.tscn")

var plant = null
var timer = 0

var dimentions : Vector2
var side_length : int

signal plant_grown

func _ready():
	$TopCollision.connect("clicked", self, "on_left_click")
	$DropZone.connect("released", self, "on_data_dropped")
	var polygon = $DropZone/CollisionPolygon2D.polygon
	dimentions.y = abs(polygon[0].y) + abs(polygon[2].y)
	dimentions.x = abs(polygon[1].x) + abs(polygon[3].x)
	side_length = dimentions.x

func _process(delta):
	pass

func on_left_click():
	# print(name, " clicked")
	# add_plant(load("res://Resources/Plants/red_plant.tres"))
	pass

func on_data_dropped(data):
	add_plant(PlantDatabase.get_plant(data.item.name))

func add_plant(plant: PlantResource):
	$TopCollision.disabled = true
	self.plant = Plant.instance()
	self.add_child(self.plant, true)
	self.plant.initialise(self, plant)
	self.plant.position = Vector2(randi() % 20 - 10, randi() % 20 - 10)
	self.plant.connect("tree_exited", self, "on_plant_removed")
	self.plant.connect("plant_grown", self, "on_plant_grown")
	
func get_plant():
	return plant

func on_plant_removed():
	$TopCollision.disabled = false
	plant = null
	
func on_plant_grown(plant: PlantResource):
	emit_signal("plant_grown", get_index(), plant)
