extends Node2D

# Declare member variables here. Examples:
var gui
const speed = 360
const type = "player"
var teste = 0
func _ready():
	self.get_child(0).animation = "run"
	
var actual_position = Vector2(0,0)

func _process(delta):
	change_animation()
	if Input.is_action_pressed("move_left"):
		self.position.x -= speed * delta
	if Input.is_action_pressed("move_right"):
		self.position.x += speed * delta
	if Input.is_action_pressed("move_up"):
		self.position.y -= speed * delta
	if Input.is_action_pressed("move_down"):
		self.position.y += speed * delta

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
	elif area.get_parent().type == "root":
		$HitSound.play()
		area.get_parent().get_parent().queue_free()
	else:
		pass
	
func change_animation():
	if Input.is_action_pressed("atack"):
		self.get_child(0).animation = "atack"
	else:
		if self.position != actual_position:
			actual_position = self.position
			self.get_child(0).animation = "run"
		else:
			pass
			self.get_child(0).animation = "idle"


func _on_Sprite_animation_finished():
	pass # Replace with function body.
