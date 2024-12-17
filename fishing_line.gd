extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_point(to_local($"../Links/1/CollisionShape2D".global_position))
	add_point(to_local($"../Links/2/CollisionShape2D".global_position))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_point_position(0, to_local($"../Links/1/CollisionShape2D".global_position))
	set_point_position(1, to_local($"../Links/2/CollisionShape2D".global_position))
