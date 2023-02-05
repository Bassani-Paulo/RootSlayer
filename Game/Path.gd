extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal straightReady(target)

var direction
var counter = 0
const speed = 40
const refreshRate = 6
var current = 0
var ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Cooldown").start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current%refreshRate == 0:
		
		add_point(self.position+counter*direction)
		counter+=speed
	current+=1
	if ready:
		var tip = (self.position+counter*direction)
		if tip.x > 1920 || tip.x < 0 || tip.y > 1080 || tip.y < 0 :
			emit_signal("straightReady", tip-direction)
			ready = false
			get_node("Cooldown").start()
	
	pass


func _on_Cooldown_timeout():
	ready = true
	pass # Replace with function body.
