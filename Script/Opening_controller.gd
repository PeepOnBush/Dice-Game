class_name OpeningController extends Control  

 

@onready var start_button = $Panel/VBoxContainer/Start
@onready var exit_button = $Panel/VBoxContainer/End
@onready var dice_nodes = get_tree().get_nodes_in_group("dice_group")
@onready var ui_panel = self



func _ready():
	ui_panel.visible = true  # Hide UI after starting
	GbFlag.start = false
	start_button.pressed.connect(_on_start_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
	# Freeze all dice initially
	for dice in dice_nodes:
		dice.freeze = true

func _on_start_pressed():
	get_node("/root/Main/SFX/ButtonClick").play()
	for dice in dice_nodes:
		dice.freeze = false
	GbFlag.start = true
	ui_panel.visible = false  # Hide UI after starting

func _on_exit_pressed():
	get_tree().quit()
