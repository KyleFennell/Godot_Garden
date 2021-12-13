extends Area2D

signal released
export var disabled : bool = false

func _ready():
	self.connect("mouse_entered", self, "_on_DropZone_mouse_entered")
	self.connect("mouse_exited", self, "_on_DropZone_mouse_exited")
	self.connect("tree_exited", self, "_on_DropZone_mouse_exited")
	self.add_to_group("dropZone")

func can_drop_data(data):
	return data

func drop_data(data):
	emit_signal("released", data)

func _on_DropZone_mouse_entered():
	DragDropManager.setHoveredNode(self)

func _on_DropZone_mouse_exited():
	DragDropManager.unsetHoveredNode(self)
