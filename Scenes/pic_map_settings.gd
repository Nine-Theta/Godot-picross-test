extends Node2D

@export var puzzleSize = Vector2i(5,5)
@export var pixelSize: int = 16

var puzzleArray: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	_resetPuzzle()
	pass # Replace with function body.

func _resetPuzzle() -> void:
	for child in $HBoxContainer.get_children():
		child.queue_free()
	for child in $VBoxContainer.get_children():
		child.queue_free()
		
	$HBoxContainer.size.x = pixelSize * (puzzleSize.x -1)
	$VBoxContainer.size.y = pixelSize * (puzzleSize.y -1)
	
	for y in range(puzzleSize.y):
		var row = []
		for x in range(puzzleSize.x):
			row.append(randi_range(0,1))
		puzzleArray.append(row)
	print(puzzleArray)
	
	for x in range(puzzleSize.x):
		var newPanel = preload("res://Scenes/VerPicLabel.tscn").instantiate()
		(newPanel.get_child(0) as Label).text = ""
		print("label before: "+(newPanel.get_child(0) as Label).text)
		var counter: int = 0
		for y in range(puzzleSize.y):
			if(puzzleArray[y][x] == 0):
				if(counter != 0):
					(newPanel.get_child(0) as Label).text += "\n" + str(counter)
					counter = 0
			else:
				counter += 1
			print("y: "+str(y) +" val: "+str(puzzleArray[y][x])+ " counter: " + str(counter))
		if(counter != 0):
			(newPanel.get_child(0) as Label).text += "\n" + str(counter)
		print("label after: " +(newPanel.get_child(0) as Label).text)
		$HBoxContainer.add_child(newPanel)
		print(x)
	
	for y in range(puzzleSize.y):
		var newPanel = preload("res://Scenes/HorPicLabel.tscn").instantiate()
		(newPanel.get_child(0) as Label).text = ""
		print("label before: "+(newPanel.get_child(0) as Label).text)
		var counter: int = 0
		for x in range(puzzleSize.x):
			if(puzzleArray[y][x] == 0):
				if(counter != 0):
					(newPanel.get_child(0) as Label).text += " " + str(counter)
					counter = 0
			else:
				counter += 1
			print("y: "+str(y) +" val: "+str(puzzleArray[y][x])+ " counter: " + str(counter))
		if(counter != 0):
			(newPanel.get_child(0) as Label).text += " " + str(counter)
		print("label after: " +(newPanel.get_child(0) as Label).text)
		$VBoxContainer.add_child(newPanel)
		print(y)
	
	$TileMapLayer.set_mapSize(puzzleSize)

func isCoordEmpty(coord: Vector2i) -> bool:
	var One: int = 0
	print(puzzleArray.size())
	if puzzleArray[coord.y][coord.x] == One:
		return true
	else: return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
