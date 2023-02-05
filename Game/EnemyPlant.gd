extends Node2D

const ACCEL = 0.025

const type = "enemy"
var PLAYER: Node2D
var playerPosition: Vector2
const SPEED = 240
var isDying = false
var oppacity = 1

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Line2D").head = get_node("Head")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isDying:
		var overlapingAreas = get_node("Area2D").get_overlapping_areas()
		var distance = PLAYER.position - self.position
		var direction = distance/sqrt(pow(distance.x, 2) + pow(distance.y, 2))
		
		for area in overlapingAreas:
			if area.get_parent().type == "enemy":
				direction += (position - area.get_parent().position).normalized()
		direction = direction.normalized()
		
		velocity = velocity.linear_interpolate(direction * SPEED, ACCEL)
		self.position += velocity*delta
		look_at(position + velocity)
	else:
		oppacity -= 0.01
		self.modulate = Color(1,1,1,oppacity)
		if oppacity <= 0:
			queue_free()

func die():
	isDying = true 
