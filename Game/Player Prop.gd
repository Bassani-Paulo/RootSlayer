extends Node2D

# Declare member variables here. Examples:
const speed = 240
const type = "player"
var teste = 0

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
	print(teste)
	teste += 1
	if area.get_parent().type == "enemy":
		get_tree().reload_current_scene()
	elif  area.get_parent().type == "wall":
		get_tree().reload_current_scene()
	elif area.get_parent().type == "root":
		print("kill")
	pass # Replace with function body.pass # Replace with function body.
