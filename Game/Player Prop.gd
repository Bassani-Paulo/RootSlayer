extends Node2D

# Declare member variables here. Examples:
const speed = 240
const type = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		self.position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		self.position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		self.position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		self.position.y += speed * delta

func _on_Area2D_area_entered(area):
	if area.get_parent().type == "enemy":
		get_tree().reload_current_scene()
	elif  area.get_parent().type == "wall":
		get_tree().reload_current_scene()
	elif area.get_parent().type == "root":
		area.get_parent().get_parent().queue_free()
	pass # Replace with function body.pass # Replace with function body.
