extends Control

@onready var dice_container = get_node("/root/Main/Node2D") 


@onready var d4_button: Button = $Panel/ScrollContainer/GridContainer/D4
@onready var d6_button: Button = $Panel/ScrollContainer/GridContainer/D6
@onready var d8_button: Button = $Panel/ScrollContainer/GridContainer/D8
@onready var d10_button: Button = $Panel/ScrollContainer/GridContainer/D10
@onready var d100_button: Button = $Panel/ScrollContainer/GridContainer/D100
@onready var d12_button: Button = $Panel/ScrollContainer/GridContainer/D12
@onready var d20_button: Button = $Panel/ScrollContainer/GridContainer/D20


@onready var dice_scene = preload("res://dice.tscn") 

func _ready() -> void:
	visible = false
	# Connect all buttons
	d4_button.pressed.connect(_on_spawn_d6)
	d6_button.pressed.connect(_on_spawn_d6)
	d8_button.pressed.connect(_on_spawn_d6)
	d10_button.pressed.connect(_on_spawn_d6)
	d12_button.pressed.connect(_on_spawn_d6)
	d20_button.pressed.connect(_on_spawn_d6)
	d100_button.pressed.connect(_on_spawn_d6)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		visible = not visible
		_toggle_dice_physics(not visible)

func _on_spawn_d6() -> void:
	var dice = dice_scene.instantiate()
	dice.set_collision_layer(2) 
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _toggle_dice_physics(enable: bool) -> void:
	for dice in get_tree().get_nodes_in_group("dice_group"):
		if dice is RigidBody2D:
			dice.freeze = not enable
			dice.sleeping = not enable
