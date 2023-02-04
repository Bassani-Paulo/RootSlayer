extends Node2D

# Declare member variables here. Examples:
const speed = 240
const type = "player"
var teste = 0
var axe = preload("res://Gun.tscn")
func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		self.position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		self.position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		self.position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		self.position.y += speed * delta

func death_process():
	$DeathSound.play()
	get_tree().paused = true
	yield(get_tree().create_timer(1), "timeout")
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_Area2D_area_entered(area):
	if area.get_parent().type == "enemy":
		death_process()
	elif  area.get_parent().type == "wall":
		death_process()
	elif area.get_parent().type == "root":
		$HitSound.play()
		area.get_parent().get_parent().queue_free()
	elif area.get_parent().type == "gun":
		area.get_parent().queue_free()
		var personal_axe =  axe.instance()
		add_child(personal_axe)
		personal_axe.position.x = -400
		personal_axe.position.y = -400
	else:
		pass
