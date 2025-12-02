extends Node

@onready var dice_scene = preload("res://dice.tscn")
@onready var dice_container = get_node("/root/Main/Node2D")  #holds your Dice nodes


var results = []

var start : bool = false
var dragging_dice_count: int = 0
var too_fast : bool = false
