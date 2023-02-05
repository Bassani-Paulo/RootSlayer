extends Line2D

const type = "root"

const refreshRate = 12
var current = 0
var head:Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	if current%refreshRate == 0:
		add_point(head.global_position)
		var area = Area2D.new()
		var colShape = CollisionShape2D.new()
		var shape = CapsuleShape2D.new()
		shape.radius = 10
		shape.height = 40
		colShape.shape = shape
		colShape.rotation_degrees = 90
		area.add_child(colShape)
		area.position = head.global_position
		area.look_at(get_parent().PLAYER.position)
		add_child(area)	
	current+=1
	pass
