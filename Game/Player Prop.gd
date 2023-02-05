extends Node2D

# Declare member variables here. Examples:
var gui
const speed = 360
const type = "player"
var teste = 0
var animation_tree
var animation_state_machine
var axeProp = preload("res://Gun.tscn")
var axe = null
var isAtackActivated = false

func _ready():
	animation_tree = $AnimationTree
	animation_state_machine = $AnimationTree.get("parameters/playback")
	animation_state_machine.travel("Idle")
	
var actual_position = Vector2(0,0)

func _process(delta):
	var _movement_vector = Vector2(0,0)

	if axe != null and Input.is_action_pressed("attack"):
		animation_state_machine.travel("AxeUpAttack")
		$AttackSound.play()
		isAtackActivated = true
		axe.hide()
	else:
		if axe != null and animation_state_machine.get_current_node() != "AxeUpAttack":
			axe.show()
			isAtackActivated = false
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
			_movement_vector = _movement_vector.normalized()
			animation_state_machine.travel("Move")
		
		self.position += (_movement_vector.normalized()) * speed * delta

func death_process():
	$DeathSound.play()
	gui.set_best_time()
	get_tree().paused = true
	yield(get_tree().create_timer(1), "timeout")
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_Area2D_area_entered(area):
	if area.get_parent().type == "enemy":
		death_process()
	elif  area.get_parent().type == "wall":
		death_process()
	elif isAtackActivated and area.get_parent().type == "root":
		$HitSound.play()
		area.get_parent().get_parent().die()
	elif area.get_parent().type == "gun":
		$HitSound.play()
		area.get_parent().queue_free()
		axe =  axeProp.instance()
		add_child(axe)
		axe.position.x = -400
		axe.position.y = -400
	else:
		pass
	
