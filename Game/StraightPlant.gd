extends Node2D

const type = "enemy"
const SPEED = 1000
var PLAYER: Node2D
var target:Vector2
var ready = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var distance = PLAYER.position - self.position
	get_node("Path").direction = distance/sqrt(pow(distance.x, 2) + pow(distance.y, 2))
	get_node("Path").connect("straightReady", self, "on_path_ready")
	pass # Replace with function body.
	

func on_path_ready(target):
	ready = true
	self.target = target
	

func _process(delta):
	if ready:
		look_at(target)
		var distance = target - self.position
		var direction = distance/sqrt(pow(distance.x, 2) + pow(distance.y, 2))
		self.position += direction*SPEED*delta


