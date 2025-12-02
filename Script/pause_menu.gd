extends CanvasLayer


@onready var tab_container: TabContainer = $TabContainer
@onready var dice_menu := $TabContainer/DiceMenu

@onready var dice_container = get_node("/root/Main/Node2D")  # holds your Dice nodes


@onready var pause_menu: CanvasLayer = $"."
@onready var d_4: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D4
@onready var d_6: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D6
@onready var d_8: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D8
@onready var d_10: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D10
@onready var d_100: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D100
@onready var d_12: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D12
@onready var d_20: Button = $TabContainer/DiceMenu/Panel/ScrollContainer/GridContainer/D20

@onready var diceD4_scene = preload("res://diceD4.tscn") #d4 dice scene
@onready var diceD6_scene = preload("res://dice.tscn") #d6 dice scene
@onready var diceD8_scene = preload("res://diceD8.tscn") #d8 dice scene
@onready var diceD10_scene = preload("res://diceD10.tscn") #d10 dice scene
@onready var diceD12_scene = preload("res://diceD12.tscn") #d12 dice scene
@onready var diceD20_scene = preload("res://diceD20.tscn") #d20 dice scene

var is_paused: bool = false

func _ready() -> void:
	d_4.pressed.connect(_on_spawn_d4)
	d_6.pressed.connect(_on_spawn_d6)
	d_8.pressed.connect(_on_spawn_d8)
	d_10.pressed.connect(_on_spawn_d10)
	d_100.pressed.connect(_on_spawn_d6)
	d_12.pressed.connect(_on_spawn_d12)
	d_20.pressed.connect(_on_spawn_d20)
	_toggle_dice_physics(not visible)
	hide_pause_menu()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not is_paused:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	is_paused = true
	visible = true
	tab_container.current_tab = 0

func hide_pause_menu() -> void:
	is_paused = false
	visible = false


func _on_spawn_d4() -> void:
	var dice = diceD4_scene.instantiate()
	dice.set_collision_layer(2)  
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _on_spawn_d6() -> void:
	var dice = diceD6_scene.instantiate()
	dice.set_collision_layer(2) 
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _on_spawn_d8() -> void:
	var dice = diceD8_scene.instantiate()
	dice.set_collision_layer(2) 
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _on_spawn_d10() -> void:
	var dice = diceD10_scene.instantiate()
	dice.set_collision_layer(2)  
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _on_spawn_d12() -> void:
	var dice = diceD12_scene.instantiate()
	dice.set_collision_layer(2) 
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _on_spawn_d20() -> void:
	var dice = diceD20_scene.instantiate()
	dice.set_collision_layer(2) 
	dice.global_position = Vector2(100, -75)
	dice_container.add_child(dice)
	dice.add_to_group("dice_group")

func _toggle_dice_physics(enable: bool) -> void:
	for dice in get_tree().get_nodes_in_group("dice_group"):
		if dice is RigidBody2D:
			dice.freeze = not enable
			dice.sleeping = not enable
