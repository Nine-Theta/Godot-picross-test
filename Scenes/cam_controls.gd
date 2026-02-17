extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_E)):
		position.y += 1.0;
	if(Input.is_key_pressed(KEY_Q)):
		position.y -= 1.0;
	if(Input.is_key_pressed(KEY_A)):
		position.x -= 1.0;
	if(Input.is_key_pressed(KEY_D)):
		position.x += 1.0;
	pass
