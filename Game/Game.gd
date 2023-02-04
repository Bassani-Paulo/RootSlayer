extends Node2D


# Declare member variables here. Examples:
var enemyPlant = preload("res://EnemyPlant.tscn")
var playerProp = preload("res://Player Prop.tscn")
var plants: Array
var player: Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	player = playerProp.instance()
	add_child(player)


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
