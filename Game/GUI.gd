extends CanvasLayer

const LEVEL_COMPLETED_TWEEN_DURATION = 1
onready var current_time := $Control/MarginContainer/Elements/HBoxContainer/HBoxLeft/VBoxLevelInfo2/LevelNameContainer/LevelLabel
onready var best_time := $Control/MarginContainer/Elements/HBoxContainer/HBoxMiddle/VBoxLevelInfo/LevelNameContainer/LevelLabel
var time_start = 0
var time_now = 0

func _process(delta):
	set_current_time()
	
func _ready():
	time_start = OS.get_unix_time()
	best_time.text =  str(Global.best_time)

func set_current_time():
	time_now = OS.get_unix_time() - time_start
	current_time.text = str(time_now)
	
func set_best_time():
	time_now = int(OS.get_unix_time() - time_start)
	var old_best = int(best_time.text)
	if time_now > old_best:
		Global.best_time = time_now
		best_time.text =  str(time_now)

func show():
	$Control.visible = true

func hide():
	$Control.visible = false

func _send_input_action(action):
	var ev = InputEventAction.new()
	ev.action = action
	
	ev.pressed = true
	Input.parse_input_event(ev)
	ev.pressed = false
	Input.parse_input_event(ev)
