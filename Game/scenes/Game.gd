extends Node2D

class_name Game

signal change_scene(sceneType)

const sizeGrid = Global.movementLength
var offset : Vector2
onready var curLevel = 0
var needRestart = false
	
func loadFile(fileName : String):
	var file = File.new()
	file.open(fileName, File.READ)
	var content = file.get_as_text()
	print(content)
	file.close()
	return content

func loadJsonFile(fileName : String):
	var file = File.new()
	file.open(fileName, File.READ)
	var content = file.get_as_text()
	var content_as_dictionary = parse_json(content)
	file.close()
	return content_as_dictionary
	
func parseObject(coord : Vector2, object : String):
	coord *= sizeGrid
	coord += offset
	if object == '#':
		var scene = load("res://objects/Wall.tscn");
		var instance = scene.instance();
		self.add_child(instance);
		instance.position = coord
		Global.coordToObject[coord] = instance
	elif object == ' ':
		var scene = load("res://objects/Grass.tscn");
		var instance = scene.instance();
		self.add_child(instance);
		instance.position = coord
		Global.coordToObject[coord] = instance
	elif object == 'P':
		var scene = load("res://objects/Player.tscn");
		var instance = scene.instance();
		instance.connect("change_scene", self, "change_scene")
		instance.GUI = $GUI
		instance.Game = self
		self.add_child(instance);
		instance.position = coord
		Global.coordToObject[coord] = instance

func change_scene(sceneType):
	emit_signal("change_scene", sceneType)

func resetGame():
	needRestart = false
	for pr in Global.coordToObject:
		Global.coordToObject[pr].queue_free()
	Global.coordToObject = {}
	Global.finished = 0

func _unhandled_input(event):
	if event is InputEventKey and not Global.running and not needRestart:
		needRestart = true
	elif event is InputEventKey and needRestart:
		resetGame()
		emit_signal("change_scene", Global.SceneType.Main)

func buildMap(map):
	var i = 0
	var j = 0
	for h in range(len(map)):
		if(map[h] == '\n'):
			j += 1
			i = 0
			continue
		parseObject(Vector2(i, j), map[h])
		i += 1
	Global.curH = i + 1
	Global.maxH = Global.curH
	Global.curL = len(map)
	Global.maxL = Global.curL
	Global.running = true

func _init():
	print('Running')
	
func _process(delta):
	if Global.running:
		Global.timeRunning += 1
		if Global.timeRunning % 10 == 0:
			Global.curH
	
func _ready():
	var baseMapName = "map1"
	var mapFile = loadFile("res://maps/" + baseMapName + ".txt")
	var lines = mapFile.split("\n",false)
	var rows = lines.size()
	var cols = lines[0].length()
	var rect = get_viewport_rect()
	offset = Vector2.ZERO
	offset.x = (rect.size.x - Global.movementLength *cols) / 2.0
	offset.y = (rect.size.y - Global.movementLength *rows + $GUI.get_size().y) / 2.0
	
	buildMap(mapFile)
	#var jsonFile = loadJsonFile("res://maps/" + baseMapName + "_extras.json")
	
	$GUI.hide_level_completed_label()
	$GUI.hide_level_failed_label()
	$GUI.set_level_name("Level " + str(curLevel + 1))
	$GUI.show()
