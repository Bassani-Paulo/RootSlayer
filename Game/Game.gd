extends Node2D

# Declare member variables here. Examples:
var enemyPlant = preload("res://EnemyPlant.tscn")
var playerProp = preload("res://Player Prop.tscn")
var guiProp = preload("res://GUI.tscn")
var gunProp = preload("res://Gun.tscn")
var plants: Array
var player: Node2D

const sizeGrid = Global.movementLength
var offset : Vector2
onready var curLevel = 0
var needRestart = false
var gui

# Called when the node enters the scene tree for the first time.
func _ready():
	player = playerProp.instance()
	player.position = Vector2(960, 540)
	gui = guiProp.instance()
	var gun = gunProp.instance()
	gun.position = Vector2(400, 400)
	player.gui = gui
	add_child(gun)
	add_child(player)
	add_child(gui)
	
	var baseMapName = "map1"
	var mapFile = loadFile("res://maps/" + baseMapName + ".txt")
	
	buildMap(mapFile)

func parseObject(coord : Vector2, object : String):
	coord *= sizeGrid
	coord += offset
	if object == '#':
		var scene = load("res://objects/Wall.tscn");
		var instance = scene.instance();
		self.add_child(instance);
		instance.position = coord
		instance.z_index = 1
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

func _on_PlantSpawnTimer_timeout():
	var newPlant = enemyPlant.instance()
	plants.append(newPlant)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var corner = rng.randi_range(0,3)
	match (corner):
		0:
			rng.randomize()
			var position = rng.randi_range(0, 1079)
			newPlant.position = Vector2(0, position)
		1:
			rng.randomize()
			var position = rng.randi_range(0, 1919)
			newPlant.position = Vector2(position, 0)
		2:
			rng.randomize()
			var position = rng.randi_range(0, 1079)
			newPlant.position = Vector2(1919, position)
		3:
			rng.randomize()
			var position = rng.randi_range(0, 1919)
			newPlant.position = Vector2(position, 1079)
	newPlant.PLAYER = player
	add_child(newPlant)
	pass # Replace with function body.
