extends RigidBody2D

@export var max_distance: float = 200  # Maximum distance the fishing line can extend
@export var throw_force: float = 500  # Initial throwing force

var is_thrown = false
var origin_position: Vector2  # Position of the player (the line's starting point)

func _ready():
	# Ensure gravity is applied to the lure
	pass

func throw_lure(player_position: Vector2, target_position: Vector2):
	# Calculate the direction to throw the lure
	var direction = (target_position - player_position).normalized()
	# Apply an impulse to "throw" the lure
	apply_impulse(Vector2.ZERO, direction * throw_force)
	# Store the player's position as the origin for the fishing line
	origin_position = player_position
	is_thrown = true

func _integrate_forces(state):
	if is_thrown:
		# Simulate the fishing line constraint
		var current_distance = position.distance_to(origin_position)
		if current_distance > max_distance:
			# If the lure exceeds the max distance, pull it back
			var direction_to_origin = (origin_position - position).normalized()
			apply_impulse(Vector2.ZERO, direction_to_origin * (current_distance - max_distance) * 10)
