extends Node2D

@onready var total_label: Label = $Score

func _process(_delta: float) -> void:
	update_total()

func update_total() -> void:
	var total := 0
	var dice_list = get_tree().get_nodes_in_group("dice_group")

	for dice in dice_list:
		if dice.has_node("Sprite2D"):
			var sprite = dice.get_node("Sprite2D")
			total += sprite.frame + 1  # D6: frames 0–5 → face 1–6
		elif dice.has_node("SpriteD4"):
			var sprite_d4 = dice.get_node("SpriteD4")
			total += sprite_d4.frame + 1  # D4: frames 0–3 → face 1–4
		elif dice.has_node("SpriteD8"):
			var sprite_d8 = dice.get_node("SpriteD8")
			total += sprite_d8.frame + 1  # D4: frames 0–3 → face 1–4
		elif dice.has_node("SpriteD10"):
			var sprite_d10 = dice.get_node("SpriteD10")
			total += sprite_d10.frame   # D4: frames 0–3 → face 1–4
		elif dice.has_node("SpriteD12"):
			var sprite_d10 = dice.get_node("SpriteD12")
			total += sprite_d10.frame + 1   # D4: frames 0–3 → face 1–4
		elif dice.has_node("SpriteD20"):
			var sprite_d20 = dice.get_node("SpriteD20")
			total += sprite_d20.frame + 1   # D4: frames 0–3 → face 1–4
	total_label.text = "Total = " + str(total)
