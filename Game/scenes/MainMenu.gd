extends Node2D

signal change_scene(scene_type)

func _ready():
	pass

func _on_Exit_pressed():
	emit_signal("change_scene", Global.SceneType.Quit)

func _on_Help_pressed():
	emit_signal("change_scene", Global.SceneType.Help)

func _on_Play_pressed():
	emit_signal("change_scene", Global.SceneType.Game)
