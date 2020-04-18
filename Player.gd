extends KinematicBody2D

export var MAX_SPEED: int = 500
export var ACCELERATION: int = 2000
export var ROTATION_SPEED: float = 0.1
var motion: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var axis: Vector2 = get_input_axis()
	look_at_mouse()
	
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)


func get_input_axis() -> Vector2:
	var axis: Vector2 = Vector2.ZERO
	print("yolo")
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return axis.normalized()


func apply_friction(amount: int) -> void:
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO


func apply_movement(acceleration: Vector2) -> void:
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)


func look_at_mouse() -> void:
	var mouse_pos := get_local_mouse_position()
	rotation += mouse_pos.angle() * ROTATION_SPEED;
