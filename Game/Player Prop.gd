extends Node2D

# Declare member variables here. Examples:
const speed = 360
const type = "player"
var teste = 0
var axe = preload("res://Gun.tscn")
var animation_tree
var animation_state_machine

func _ready():
	animation_tree = $AnimationTree
	animation_state_machine = $AnimationTree.get("parameters/playback")
	animation_state_machine.travel("Idle")

func _process(delta):
	var _movement_vector = Vector2(0,0)

	if Input.is_action_pressed("attack"):
		animation_state_machine.travel("AxeUpAttack")

	else:
		if Input.is_action_pressed("move_left"):
			_movement_vector.x = -1
		if Input.is_action_pressed("move_right"):
			_movement_vector.x = 1
		if Input.is_action_pressed("move_up"):
			_movement_vector.y = -1
		if Input.is_action_pressed("move_down"):
			_movement_vector.y = 1
		
		if _movement_vector == Vector2(0,0):
			animation_state_machine.travel("Idle")
		else:
			animation_state_machine.travel("Move")

		self.position += (_movement_vector.normalized()) * speed * delta

func _on_Area2D_area_entered(area):
	if area.get_parent().type == "enemy":
		get_tree().reload_current_scene()
	elif  area.get_parent().type == "wall":
		get_tree().reload_current_scene()
	elif area.get_parent().type == "root":
		area.get_parent().get_parent().queue_free()
	elif area.get_parent().type == "gun":
		area.get_parent().queue_free()
		var personal_axe =  axe.instance()
		add_child(personal_axe)
		personal_axe.position.x = -400
		personal_axe.position.y = -400
	else:
		pass
