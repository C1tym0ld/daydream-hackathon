extends CharacterBody2D

const SPEED = 300.0        # Horizontal movement speed (pixels per second)
const JUMP_VELOCITY = -350.0 # Vertical speed for the jump (negative is up)
const GRAVITY = 1000.0

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if velocity.x != 0:
		$Sprite2D.animation="Walk"
	else:
		$Sprite2D.animation="default"
	if velocity.x < 0:
		$Sprite2D.flip_h=true
	if velocity.x > 0:
		$Sprite2D.flip_h=false

@onready var trigger = $"../Ghost/Area2D"
func _physics_process(delta: float) -> void:
	if trigger.overlaps_body($"."):
		$"../Ghost/Label".show()
	if not is_on_floor():                       
		velocity.y += GRAVITY * delta
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Handle Horizontal Input
	# Get_axis returns -1 (left), 1 (right), or 0 (none)
	var direction: float = Input.get_axis("ui_left", "ui_right")

	if direction:
		# Move the character by setting velocity.x
		velocity.x = direction * SPEED
	else:
		# Decelerate when no input is given (smooth stopping)
		# move_toward smoothly transitions the current velocity to 0
		velocity.x = move_toward(velocity.x, 0.0, SPEED * 10 * delta)
		# Note: Multiplying by 10 * delta makes the deceleration fast
	move_and_slide()
