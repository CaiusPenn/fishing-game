extends CharacterBody2D

@export var speed = 400  # Movement speed
var screen_size

func _ready():
	print("Player is ready!")

func _physics_process(delta):
	# Handle movement
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	# Normalize and move the player
	if input_vector.length() > 0:
		velocity = input_vector.normalized() * speed
		$playerSprite.play()
		move_and_slide()
	else:
		$playerSprite.stop()
		
	if velocity.x != 0:
		$playerSprite.animation = "walk"
		$playerSprite.flip_v = false
		$playerSprite.flip_h = velocity.x < 0
		
		
		
	
