extends Node2D

var grow_timer: Timer
var growing = true
var plot
var plant : PlantResource


func _ready():
	print("ready")
	if $ClickBox:
		$ClickBox.connect("clicked", self, "on_left_click")
	
func initialise(plot, plant: PlantResource):
	print("initialise")
	self.plot = plot
	self.plant = plant
	
	get_tree().create_timer(self.plant.grow_time).connect("timeout", self, "finished_growing")
	var sprite = Sprite.new()
	sprite.texture = self.plant.sprites[randi() % self.plant.sprites.size()]
	sprite.translate(self.plant.sprite_translation)
	sprite.region_enabled = self.plant.sprite_region_enabled
	if (sprite.region_enabled):
		sprite.region_rect = self.plant.sprite_region_rect
	self.add_child(sprite)
	
	$ClickBox.add_child(CollisionShape2D.new())
	

func finished_growing():
	print("finished growing")
	growing = false
	
func on_left_click():
	if not growing:
		self.queue_free()
