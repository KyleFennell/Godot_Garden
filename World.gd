extends Node2D

var Plot = load("res://Plot/Plot.tscn")

export var width : int = 3
export var height : int = 3
var plots = []

func _ready():
	for x in range(self.width):
		var row = []
		for y in range(self.height):
			var plot = Plot.instance()
			self.add_child((plot))
			plot.position = cartesian_to_iso(Vector2(x*plot.side_length/2, y*plot.side_length/2))
			plot.connect("plant_grown", self, "on_plant_grown")
			row.append(plot)
		plots.append(row)
		
func get_neighbour_plots(index):
	var neighbours = []
	var col = index % width
	var row = index / height
	if col > 0:
		neighbours.append(plots[row][col-1])
	if col < width-1:
		neighbours.append(plots[row][col+1])
	if row > 0:
		neighbours.append(plots[row-1][col])
	if row < height-1:
		neighbours.append(plots[row+1][col])
	return neighbours
	
func on_plant_grown(plot_index, plant: PlantResource):
	print("plant_grown", plot_index, plant)
	var neighbours = get_neighbour_plots(plot_index)
	if plant.breeds_with.size() == 0:
		return
	for neighbour_plot in neighbours:
		if neighbour_plot.plant:
			continue
		var second_parent_plots = get_neighbour_plots(neighbour_plot.get_index())
		for second_parent_plot in second_parent_plots:
			if not second_parent_plot.plant:
				continue
			if second_parent_plot.get_index() == plot_index:
				continue
			for combo in plant.breeds_with:
				if combo.name == second_parent_plot.plant.plant.name and randf() < combo.chance:
					neighbour_plot.add_plant(PlantDatabase.get_plant(combo.child))
					return
	
func cartesian_to_iso(cartesian : Vector2):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y)/2)
