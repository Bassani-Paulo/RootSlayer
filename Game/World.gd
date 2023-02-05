extends VBoxContainer

var previous_scene_type
var current_scene_type = Global.SceneType.Main

onready var scene_container = $SceneContainer

var back_queue = []

var scenes = {
	Global.SceneType.Main: preload("res://scenes/MainMenu.tscn"),
	Global.SceneType.Game: preload("res://Game.tscn"),
}

func _ready():
	Global.world = self
	$ButtonContainer/BackButton.connect("pressed", self, "back")
	_load_scene(current_scene_type)
	
func _load_scene(scene_type):
	var scene = scenes[scene_type].instance()
	scene.connect("change_scene", self, "change_scene")
	for child in scene_container.get_children():
		child.queue_free()
	scene_container.add_child(scene)
	if scene_type in [Global.SceneType.Main, Global.SceneType.Game]:
		$ButtonContainer.visible = false
	else:
		$ButtonContainer.visible = true
	back_queue.push_front(current_scene_type)
	current_scene_type = scene_type

#func _unhandled_input(event):
#	if event.is_action_pressed("ui_back"):
#		back()

func change_scene(scene_type):
	if scene_type == Global.SceneType.Quit:
		quit()
	else:
		_load_scene(scene_type)

func back():
	var prev_scene_type = back_queue.pop_front()
	change_scene(prev_scene_type)
	# don't push 'back' actions to stack
	back_queue.pop_front()

func quit():
	queue_free()
	get_tree().quit(0)
