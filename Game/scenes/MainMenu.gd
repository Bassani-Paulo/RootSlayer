extends Node2D

signal change_scene(scene_type)

func _ready():
	$"Credits Text".visible = false

func _on_Exit_pressed():
	get_tree().quit(0)

func _on_Credits_pressed():
	$"Credits Text".visible = not $"Credits Text".visible

func _on_Play_pressed():
	emit_signal("change_scene", Global.SceneType.Game)
