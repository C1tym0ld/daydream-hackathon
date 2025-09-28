extends CharacterBody2D

const SPEED = 500.0        # Horizontal movement speed (pixels per second)
const JUMP_VELOCITY = -800.0 # Vertical speed for the jump (negative is up)
const GRAVITY = 1000.0
# Add this line at the top of your script (outside of any function)
signal pressedYesOrNo(result: String)
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if velocity.y != 0:
		$Sprite2D.animation="Jumping"
	elif velocity.x != 0:
		$Sprite2D.animation="Walk"
	else:
		$Sprite2D.animation="default"
	if velocity.x < 0:
		$Sprite2D.flip_h=true
	if velocity.x > 0:
		$Sprite2D.flip_h=false

func _physics_process(delta: float) -> void:
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

@onready var trigger = $"../Ghost/Area2D"
func _on_area_2d_body_entered(body: Node2D) -> void:
		$"../Ghost/Label".text = "Hello Friend! What brings you here?" # Set your text first
		$"../Ghost/Label".show() 
		await get_tree().create_timer(2).timeout
		$"../Player/Label".text = "I want to escape this dungeon!"
		$"../Player/Label".show() 
		await get_tree().create_timer(2).timeout
		$"../Ghost/Label".text = "What makes you say that?"
		await get_tree().create_timer(2).timeout
		$"../Ghost/Label".text = "It’s so wonderful down here!"
		$"../Player/Label".hide() 
		await get_tree().create_timer(2).timeout
		$"../Player/Label".text = "I have been here for 2 years"
		$"../Player/Label".show() 
		$"../Ghost/Label".hide()
		await get_tree().create_timer(2.5).timeout
		$"../Player/Label".text = "and you are the first interaction I’ve had since!"
		await get_tree().create_timer(3.5).timeout
		$"../Player/Label".hide()
		await get_tree().create_timer(1.5).timeout
		$"../Player/Label".text = "Surely you can help me return?"
		$"../Player/Label".show()
		await get_tree().create_timer(1.5).timeout
		$"../Ghost/Label".text= "."
		$"../Ghost/Label".show()
		$"../Player/Label".hide()
		await get_tree().create_timer(0.75).timeout
		$"../Ghost/Label".text= ".."
		await get_tree().create_timer(0.75).timeout
		$"../Ghost/Label".text= "..."
		await get_tree().create_timer(1.5).timeout
		$"../Ghost/Label".text= "Fine."
		await get_tree().create_timer(2.5).timeout
		$"../Ghost/Label".text= "I’ll be generous this one time."
		await get_tree().create_timer(2.5).timeout
		$"../Ghost/Label".text= "I will open a path for you, but first, 
		answer this question."
		await get_tree().create_timer(2.5).timeout
		$"../Ghost/Label".text= "To leave, all of us ghosts may die."
		await get_tree().create_timer(2.5).timeout
		$"../Ghost/Label".text= "Would you still like to leave?"
		$VBoxContainer.show() # Example: Show your VBoxContainer with buttons
