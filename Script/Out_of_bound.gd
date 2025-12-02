class_name OutOfBounds extends Area2D

@onready var taunt: Label = $"../Taunt"
@onready var taunt_timer: Timer = $"../Timer"
@onready var falling: AudioStreamPlayer = $"../SFX/Falling"

var taunt_messages = [
	"You toss too fast, dummy!",
	"Bro, that's my dice",
	"Calm down, turbo.",
	"Slow your roll, chaos goblin.",
	"Try playing the game, not breaking it.",
	"I bought that from ebay, what are you doing",
	"Dice go *IN* the box, genius.",
	"Who hurt you?",
	"Yeah gg, buddy.",
	"Are your hands okay?"
]

func _ready() -> void:
	taunt.visible = false
	taunt_timer.one_shot = true
	taunt_timer.wait_time = 3
	taunt_timer.timeout.connect(_on_taunt_timeout)
	connect("body_entered", Callable(self, "_on_bound_entered"))

func _on_bound_entered(body):
	if body is RigidBody2D:
		falling.play()
		var random_taunt = taunt_messages[randi() % taunt_messages.size()]
		show_taunt(random_taunt)
		GbFlag.too_fast = true
		body.queue_free()

		var remaining = get_tree().get_nodes_in_group("dice_group").size() - 1
		print("Remaining dice:", remaining)


func show_taunt(text: String):
	taunt.text = text
	taunt.visible = true
	taunt_timer.start()

func _on_taunt_timeout():
	taunt.visible = false
