extends Area2D

signal change_scene(scene_type)

const movementLength : int = 32
var velocity : Vector2 = Vector2()
var isAlive : bool = true
var GUI = null
var finished: bool = false
var walkingOver = null
var Game = null

var reflect: bool

func _init():
	reflect = false
	
func _updatePlayerPosition(destinationPosition):
	if self.walkingOver != null:
		var del = self.walkingOver.action(Game)
		if del:
			self.walkingOver.queue_free()
		self.walkingOver = null
	else:
		Global.coordToObject.erase(self.position)
	self.position = destinationPosition
	Global.coordToObject[self.position] = self
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			return true
	return false
	
func _killPlayer():
	Global.coordToObject.erase(self.position)
	self.isAlive = false
	self.visible = false
	GUI.show_level_failed_label(false)
	Global.running = false

func _finish():
	if not finished:
		self.finished = true
		Global.finished += 1
		self.visible = false
		if Global.finished == 2:
			GUI.show_level_completed_label(false)
			Global.running = false

func _physics_process(_delta):
	if not Global.running:
		return false
	if self.finished:
		return
	if not self.position in Global.coordToObject:
		return
	var dir = Vector2(0, 0)
	if Input.is_action_just_pressed("move_left"):
		dir = Vector2.LEFT
	if Input.is_action_just_pressed("move_right"):
		dir = Vector2.RIGHT
	if Input.is_action_just_pressed("move_up"):
		dir = Vector2.UP
	if Input.is_action_just_pressed("move_down"):
		dir = Vector2.DOWN
	if self.reflect:
		dir.x *= -1
	var destPosition = self.position +  dir * Global.movementLength
	_updatePlayerPosition(destPosition)
	
