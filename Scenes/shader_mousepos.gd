extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_viewport().debug_draw = Viewport.DEBUG_DRAW_WIREFRAME
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos = get_viewport().get_mouse_position()
	var t = Vector4(pos.x, pos.y, 0.0, 1.0);
	
	t.x /= get_viewport().size.x
	t.x = t.x * 2 -1
	t.y /= get_viewport().size.y
	t.y = 1 - t.y * 2
	t.x = clampf(t.x,-1.0,1.0)
	t.y = clampf(t.y, -1.0, 1.0)
	t.z = 0.0;
	t.w = 1.0;
	#get_active_material(0).set_shader_parameter("target", t)
	# print(t);
	pass
