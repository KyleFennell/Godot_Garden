extends Node

var plants = Array()

func _ready():
	var directory = Directory.new()
	directory.open("res://Resources/Plants")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while(filename):
		if not directory.current_is_dir():
			print("added item:", filename)
			plants.append(load("res://Resources/Plants/%s" % filename))
		
		filename = directory.get_next()
	
	process_plant_breeding_pairs()
		
func get_plant(plant_name):
	for p in plants:
		if p.name == plant_name:
			return p
	
	return null

func process_plant_breeding_pairs():
	var directory = Directory.new()
	directory.open("res://Resources/BreedingPairs")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while(filename):
		if not directory.current_is_dir():
			print("added breeding_pair:", filename)
			var bp: BreedingPair = load("res://Resources/BreedingPairs/%s" % filename)
			bp.parent1.breeds_with.append({"name": bp.parent2.name, "chance": bp.chance, "child": bp.child.name})
			bp.parent2.breeds_with.append({"name": bp.parent1.name, "chance": bp.chance, "child": bp.child.name})
		filename = directory.get_next()
	pass
	
	
	
	
