extends Node

var coordToObject = {}

const movementLength : int = 32

enum SceneType {Quit, Main, Game, Credits}

var running = false
var finished = 0
var world
var maxH = 0
var maxL = 0
var curH = 0
var curL = 0
var timeRunning = 0
var best_time = 0

func _ready():
	pass
