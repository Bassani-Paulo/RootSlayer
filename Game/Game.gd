extends Node2D


# Declare member variables here. Examples:
var enemyPlant = preload("res://EnemyPlant.tscn")
var playerProp = preload("res://Player Prop.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var plant = enemyPlant.instance()
	var player = playerProp.instance()
	plant.PLAYER = player
	plant.position = Vector2(500, 500)
	add_child(plant)
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
