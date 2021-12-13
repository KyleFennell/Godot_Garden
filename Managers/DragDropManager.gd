extends Node

var hoveredElement = null
var selectedElement = null
var dropData

func unsetHoveredNode(node):
	if self.hoveredElement == node:
		self.hoveredElement = null

# Returns boolean if it is the new top hovered object
func setHoveredNode(node1):
	if self.hoveredElement == null or self.hoveredElement == node1:
		self.hoveredElement = node1
		return true
 
	var nodes = get_tree().get_nodes_in_group('dropZone')
	var hoveredPosition = 0
	var i = 0
	for node in nodes:
		
		if node == self.hoveredElement:
			hoveredPosition = i
			break
		i += 1

	var node1Position = 0
	i = 0
	for node in nodes:
		if node == node1:
			node1Position = i
			break
		i += 1

	if node1Position >= hoveredPosition:
		self.hoveredElement = node1
		return true
	else:
		return false

func _input(event: InputEvent):
	if event is InputEventMouseButton && event.is_action_released("click"):
		if self.hoveredElement == null:
			# No object is being clicked, so deselect selected node
			self.selectedElement = null
			if self.dropData and self.dropData.has("fail_callback"):
				var callback = self.dropData.fail_callback
				print("drop failed")
				callback["func"].call_funcv(callback["args"])
		elif not self.hoveredElement.disabled:
			if self.hoveredElement.can_drop_data(self.dropData):
				# Call left click for only the top object that is being clicked
				self.hoveredElement.drop_data(self.dropData)
		self.dropData = null
