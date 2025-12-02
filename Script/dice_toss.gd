extends RigidBody2D


@onready var bounce_sound = $"../../SFX/DiceBounce"
@onready var bounce_bounce_2: = $"../../SFX/DiceBounce2"
@onready var shake_sound = $"../../SFX/DiceShaking"
@onready var dust_effect := $"../../DustEffect"


var drag_duration := 0.0
var shake_sound_played := false
var dragging := false
var last_mouse_pos := Vector2.ZERO
var timer = 0.0
var final_value_chosen = false
var last_drag_velocity := Vector2.ZERO
var frame_change_cooldown := 0.0
var has_bounced := false  # ✅ Only allow one frame change per toss

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		freeze = true
		global_position = Vector2(25, 25)

func _ready():
	contact_monitor = true
	max_contacts_reported = 4
	input_pickable = true
	gravity_scale = 1


func _integrate_forces(state):
	if not dragging and frame_change_cooldown <= 0.0 and not has_bounced:
		for i in range(state.get_contact_count()):
			var collider = state.get_contact_collider_object(i)
			if collider and collider.name.begins_with("Wall"):

				# Pick direction based on wall name
				var direction = Vector2.ZERO
				match collider.name:
					"WallLeft":
						direction = Vector2(1, 0)  # Right
					"WallRight":
						direction = Vector2(-1, 0) # Left
					"WallTop":
						direction = Vector2(0, 1)  # Down
					"WallBottom":
						direction = Vector2(0, -1) # Up

				# Emit dust at contact point
				dust_effect.global_position = state.get_contact_local_position(i)
				dust_effect.rotation = direction.angle()
				dust_effect.restart()         # Optional in case it's stuck
				dust_effect.emitting = true   # Play again

				if has_node("Sprite2D"):
					get_node("Sprite2D").frame = randi() % 6
				if has_node("SpriteD4"):
					get_node("SpriteD4").frame = randi() % 4
				if has_node("SpriteD8"):
					get_node("SpriteD8").frame = randi() % 8
				if has_node("SpriteD10"):
					get_node("SpriteD10").frame = randi() % 10
				if has_node("SpriteD12"):
					get_node("SpriteD12").frame = randi() % 12
				if has_node("SpriteD20"):
					get_node("SpriteD20").frame = randi() % 20
				frame_change_cooldown = 0.4
				has_bounced = true
				
				# Sounds
				if bounce_sound:
					bounce_sound.pitch_scale = randf_range(0.6, 1.1)
					bounce_sound.play()
					bounce_bounce_2.pitch_scale = randf_range(0.9 , 1.1)
					bounce_bounce_2.play()
				break


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_global_mouse_position().distance_to(global_position) < 75:
				start_drag()
		else:
			stop_drag()

func _physics_process(delta):
	if frame_change_cooldown > 0.0:
		frame_change_cooldown -= delta

	# Re-check for mouse grab if not already dragging
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		if not dragging and mouse_pos.distance_to(global_position) < 75:
			start_drag()

	if dragging:
		# Follow mouse smoothly
		var target = get_global_mouse_position()
		var dir = target - global_position
		last_drag_velocity = dir / delta
		linear_velocity = dir * 250 * delta

		# Track how long dragging has occurred
		drag_duration += delta

		# Shake SFX condition
		if GbFlag.dragging_dice_count >= 1 and drag_duration >= 1.2 and not shake_sound_played:
			if shake_sound:
				shake_sound.play()
			shake_sound_played = true
	else:
		# Not dragging, reset duration + shake trigger
		drag_duration = 0.0
		shake_sound.stop()
		shake_sound_played = false
		
		#die has settled
	if linear_velocity.length() < 10 and angular_velocity < 1 and not final_value_chosen and GbFlag.start == true :
			timer += delta
			if timer >= 2.75:
				final_value_chosen = true
	else:
		timer = 0.0


func start_drag():
	if not dragging:
		dragging = true
		GbFlag.dragging_dice_count += 1
		last_mouse_pos = get_global_mouse_position()
		gravity_scale = 0
		linear_velocity = Vector2.ZERO
		angular_velocity = 0

func stop_drag():
	if dragging:
		dragging = false
		GbFlag.dragging_dice_count -= 1
		gravity_scale = 1
		has_bounced = false
		if last_drag_velocity.length() > 25000:
			last_drag_velocity = last_drag_velocity.normalized() * 25000
		linear_velocity = last_drag_velocity * 0.3
 
