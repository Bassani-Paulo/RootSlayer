extends Button

func _pressed():
	Global.world._load_scene(Global.SceneType.Game)
