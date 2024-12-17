extends CharacterBody2D

var line_length = 500.0
var casting = false
var cast_time = 0.0

var time = 2

var target_y = 0

var reeled_in = 0.0
const REELED_AMOUNT = 5
const WALK_OFFSET = 3
var walk_offset = 0
 

func _ready() -> void:
	self.target_y = $"../1".global_position.y
	global_position = $"../1".global_position
	 
func _quadratic_bezier(t: float):
	var p0 = Vector2(self.line_length - self.reeled_in+self.walk_offset, self.target_y)
	var p1 = Vector2(self.line_length - self.reeled_in+self.walk_offset, (self.line_length - self.reeled_in)/2)
	var p2 = Vector2(self.walk_offset, self.line_length - self.reeled_in)
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var pos = q0.lerp(q1, t)
	return pos

func _physics_process(delta: float) -> void:
	# wait a bit before running
	#if count < 5:
		#count += 1
		#return
	if self.casting:
		self.cast_time += delta
		global_position = self.get_cast_pos(self.cast_time)
		return
		
	if Input.is_action_just_pressed("ui_up"):
		self.cast_rod()
		
	if Input.is_action_pressed("ui_left"):
		self.walk_offset -= WALK_OFFSET
	elif Input.is_action_pressed("ui_right"): 
		self.walk_offset += WALK_OFFSET
		
	# reel in the line if space is pressed
	if Input.is_action_pressed("ui_accept"):
		self.reeled_in = min(self.reeled_in + self.REELED_AMOUNT, self.line_length)

	$"../1".global_position.x = self.walk_offset

	if self.time >= 1:
		global_position.x = self.walk_offset
		if Input.is_action_pressed("ui_accept"):
			global_position.y = max(global_position.y - self.REELED_AMOUNT, self.target_y)
		return

	if not self.casting:
		self.time += delta / 3
		global_position = self._quadratic_bezier(self.time)
	
		
	#var y = self.calc_y(self.current_x)
	#print(self.current_x, "  ", y)
	#
	## transform the x and y values to account for the line being reeled in
	#var radius_ratio = ((self.line_length - self.reeled_in)/self.line_length)
	#var xpos = radius_ratio * self.current_x
	#var ypos = radius_ratio * y
	#
	## update lure postion. walk offset fucks it a bit
	#global_position = Vector2(xpos+self.walk_offset, ypos)
	#self.current_x -= self.x_inc * (1/radius_ratio)
#

func cast_rod():
	if self.casting or global_position.y != self.target_y:
		return
	self.cast_time = 0.0
	self.casting = true
	self.time = 0.0
	self.reeled_in = 0.0
	global_position = Vector2(0, self.walk_offset+self.line_length)
	
func get_cast_pos(t: float):
	var p0 = Vector2(self.walk_offset, self.target_y)
	var p1 = Vector2((self.line_length+self.walk_offset)/2, self.target_y-300)
	var p2 = Vector2(self.line_length+self.walk_offset, self.target_y)
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var pos = q0.lerp(q1, t)
	if pos == p2:
		self.casting = false
	return pos
#func step_cast():
	

#func _ready() -> void:
	#self.current_x = self.line_length
	#global_position = Vector2(self.line_length, 0)
	##self.line_length = self.current_x
	#
#func calc_y(x: float) -> float:
	#"""Calculate the y for the given x value on the circumference of the circle
	#y = sqr(r^2 - x^2)
	#"""
	#return pow(pow(self.line_length, 2) - pow(x, 2), 0.5)
#
#func _physics_process(delta: float) -> void:
	## wait a bit before running
	##if count < 5:
		##count += 1
		##return
		#
	#if global_position.y < 0:
		#return
	#
	#if global_position.x <= 0:
		#if Input.is_action_pressed("ui_accept"):
			#global_position = global_position - Vector2(0,self.REELED_AMOUNT)
		#return
	#
	## how does walking on a boat move the lure?
	#if Input.is_action_pressed("ui_left"):
		#self.walk_offset -= WALK_OFFSET
	#elif Input.is_action_pressed("ui_right"): 
		#self.walk_offset += WALK_OFFSET
		#
	## reel in the line if space is pressed
	#if Input.is_action_pressed("ui_accept"):
		#self.reeled_in += self.REELED_AMOUNT
		#
	#var y = self.calc_y(self.current_x)
	#print(self.current_x, "  ", y)
	#
	## transform the x and y values to account for the line being reeled in
	#var radius_ratio = ((self.line_length - self.reeled_in)/self.line_length)
	#var xpos = radius_ratio * self.current_x
	#var ypos = radius_ratio * y
	#
	## update lure postion. walk offset fucks it a bit
	#global_position = Vector2(xpos+self.walk_offset, ypos)
	#self.current_x -= self.x_inc * (1/radius_ratio)
	
		
	
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity = get_gravity() * Vector2(10,10) * delta

	#if $".".position.y > 500:
		#velocity.y = 0
		
	# Handle jump.
	#if Input.is_action_pressed("ui_up"):
	#	velocity.y = JUMP_VELOCITY
		
	
		
	#velocity.x = -200

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
