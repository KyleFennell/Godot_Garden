extends Node2D

var grow_timer: Timer
var growing = true
var plot
var plant : PlantResource

onready var inventory = preload("res://UI/Inventory/Inventory.tres")
signal plant_grown

func _ready():
	print("ready")
	if $ClickBox:
		$ClickBox.connect("clicked", self, "on_left_click")
	
func initialise(plot, plant: PlantResource):
	print("initialise")
	self.plot = plot
	self.plant = plant
	
	$ClickBox.disabled = true
	get_tree().create_timer(self.plant.grow_time).connect("timeout", self, "finished_growing")
	$AnimationPlayer.play("Growing", -1, 1/plant.grow_time)
	$Sprite.texture = ItemDatabase.get_item(plant.name).texture	
	$ClickBox.add_child(CollisionShape2D.new())
	

func finished_growing():
	print("finished growing")
	growing = false
	$ClickBox.disabled = false
	$AnimationPlayer.play("Finished_Growing")
	emit_signal("plant_grown", plant)

func animation_finished():
	if $AnimationPlayer.current_animation == "finished_growing":
		pass
		
func on_left_click():
	if not growing:
		inventory.add_item(plant.name, null, null)
		self.queue_free()
