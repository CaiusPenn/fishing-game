extends Node2D
@onready var player = $Player
@onready var lure = $Player/Lure

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("cast_lure"):  
		var mouse_position = get_global_mouse_position()
		lure.throw_lure(player.global_position, mouse_position)
