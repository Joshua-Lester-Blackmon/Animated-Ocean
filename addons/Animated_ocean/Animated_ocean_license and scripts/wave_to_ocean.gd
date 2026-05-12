@tool
extends MeshInstance3D
var reverse = false
@export var grow_uv_count : float = 10000.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if reverse == false:
		grow_uv_count = grow_uv_count - 2.5
	if reverse == true:
		grow_uv_count = grow_uv_count + 1
	if grow_uv_count < 3500:
		reverse = true
	if grow_uv_count > 11500:
		reverse = false
	
	get_active_material(0).set_shader_parameter("grow_uv_channel_1",grow_uv_count/10000.00)
