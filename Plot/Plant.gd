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
	$AnimationPlayer.play("Growing", -1, 1/plant.grow_time)
	$Sprite.texture = plant.sprites[randi() % plant.sprites.size()]
	
	$ClickBox.add_child(CollisionShape2D.new())
	

func finished_growing():
	print("finished growing")
	growing = false
	$AnimationPlayer.play("Finished_Growing")

func animation_finished():
	if $AnimationPlayer.current_animation == "finished_growing":
		pass
	
func on_left_click():
	if not growing:
		self.queue_free()
