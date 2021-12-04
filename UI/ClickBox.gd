extends Area2D

signal clicked
export var disabled : bool = false

func _ready():
	self.connect("input_event", self, "_on_ClickBox_input_event")
	self.connect("mouse_exited", self, "_on_ClickBox_mouse_exited")
	self.connect("tree_exited", self, "_on_ClickBox_mouse_exited")
	self.add_to_group("clickableObject")

func leftMouseClick():
	SingleClickManager.selectedElement = self
	emit_signal("clicked")

func _on_ClickBox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion and not self.disabled:
		SingleClickManager.setHoveredNode(self)

func _on_ClickBox_mouse_exited():
	SingleClickManager.unsetHoveredNode(self)
