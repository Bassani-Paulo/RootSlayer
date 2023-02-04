extends Node

var coordToObject = {}

const movementLength : int = 48

enum SceneType {SelectPack, Help, Quit, Main, SelectLevel, Game, Game2}

var running = false
var finished = 0
var world
