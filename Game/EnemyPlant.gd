extends Node2D

const type = "enemy"
var PLAYER: Node2D
var playerPosition: Vector2
const SPEED = 240


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Line2D").head = get_node("Head")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = PLAYER.position - self.position
	var direction = distance/sqrt(pow(distance.x, 2) + pow(distance.y, 2))
	self.position += direction*SPEED*delta
	look_at(PLAYER.position)
	pass
