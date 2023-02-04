extends Node2D

# Declare member variables here. Examples:
var enemyPlant = preload("res://EnemyPlant.tscn")
var playerProp = preload("res://Player Prop.tscn")

const sizeGrid = Global.movementLength
var offset : Vector2
onready var curLevel = 0
var needRestart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var plant = enemyPlant.instance()
	var player = playerProp.instance()
	plant.PLAYER = player
	player.position = Vector2(200, 200)
	plant.position = Vector2(1000, 600)
	add_child(plant)
	add_child(player)
	
	var baseMapName = "map1"
	var mapFile = loadFile("res://maps/" + baseMapName + ".txt")
	var lines = mapFile.split("\n",false)
	var rows = lines.size()
	var cols = lines[0].length()
	var rect = get_viewport_rect()
	offset = Vector2.ZERO
	
	buildMap(mapFile)

func parseObject(coord : Vector2, object : String):
	coord *= sizeGrid
	coord += offset
	if object == '#':
		var scene = load("res://objects/Wall.tscn");
		var instance = scene.instance();
		self.add_child(instance);
		instance.position = coord
		instance.z_index = -1
		Global.coordToObject[coord] = instance
	elif object == ' ':
		var scene = load("res://objects/Grass.tscn");
		var instance = scene.instance();
		instance.z_index = -1
		self.add_child(instance);
		instance.position = coord
		Global.coordToObject[coord] = instance
		
func loadFile(fileName : String):
	var file = File.new()
	file.open(fileName, File.READ)
	var content = file.get_as_text()
	print(content)
	file.close()
	return content
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
