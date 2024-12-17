extends Chara

var reset_state = false
var moveVector: Vector2
var pos = Vector2.ZERO
var pos_y = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pos
	
	if Input.is_action_pressed("ui_up"):
		
		var velocity = Vector2.ZERO
		var input_vector = Vector2.ZERO
		
		velocity.y -= 10
		velocity.x -= 10
		
		#translate(Vector2(1,1))
		move_body(velocity)
		#if velocity.length() > 0:
			#velocity = velocity.normalized() * 400
		#$".".sleeping = true
		#$".".position += velocity * delta
		#$".".sleeping = false 
		
func _integrate_forces(state):
	if reset_state:
		var t = Vector2.ZERO
		var g = Vector2.ZERO
		pos = $".".position
		t.x = 1
		#t.y = 600
		g.y = 1
		#g.x = 1
		state.transform = Transform2D(t, g, pos)
		reset_state = false

func move_body(targetPos: Vector2):
		moveVector = targetPos;
		reset_state = true;
		
	
	
	
	
