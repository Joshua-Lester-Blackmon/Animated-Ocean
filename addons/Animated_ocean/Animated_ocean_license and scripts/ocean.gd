@tool
extends MeshInstance3D
@export var count = 6144
@export var forward = true
@export var disp_string = ""
@export var material : Material
@export var material2 : Material
@export var envi : Environment
@export var envi2 : Environment
@export var children = 0
@export var unique_plane_cover_material: Material
@export var first_childs_child = 0
@export var scale_to_scale_v2 = Vector2()
@export var root = ""
@export var camera_3D = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_3D = str(get_viewport().get_camera_3d())
	var string = "res://addons/Animated_ocean/cache_ocean/disp_"
	var string2 = "res://addons/Animated_ocean/cache_ocean2/disp_"
	if forward == true:
		count += .22
	if forward == false:
		count -= .22
	
	
	
	string = string + str(int(count))
	string2 = string2 + str(int(count))
	
	
	if forward == true:
		if count > 6643:
			forward = false
			count -= 1
	if forward == false:
		if count < 6146:
			forward = true
			count +=1
	disp_string = string + ".exr"
	

	
	
	#Secured_code
	var pretexture = load(disp_string)
	var image = pretexture.get_image()
	var texture = ImageTexture.create_from_image(image)
	

	
	
	
	
	

	disp_string = string + ".exr"
	if camera_3D != "<Object#null>":
		if camera_3D != "<null>":
			if get_viewport().get_camera_3d().position.y > 0:
				set_surface_override_material(0,material)
				get_active_material(0).set_shader_parameter("vertex_cords_animating_data_texture", texture)
				get_viewport().get_camera_3d().environment = envi
				get_viewport().get_camera_3d().near = .05
				get_viewport().get_camera_3d().far = 4000.0
			if get_viewport().get_camera_3d().position.y < 1:
				set_surface_override_material(0,material2)
				get_viewport().get_camera_3d().environment = envi2
				get_viewport().get_camera_3d().near = 2.5
				get_viewport().get_camera_3d().far = 130.0
				get_viewport().get_camera_3d().environment.tonemap_exposure = .75 -get_viewport().get_camera_3d().position.y *-.01 
				if get_viewport().get_camera_3d().environment.tonemap_exposure > .5:
					get_viewport().get_camera_3d().environment.tonemap_exposure = get_viewport().get_camera_3d().environment.tonemap_exposure -.10
				if get_viewport().get_camera_3d().environment.tonemap_exposure > .45:
					get_viewport().get_camera_3d().environment.tonemap_exposure = get_viewport().get_camera_3d().environment.tonemap_exposure - .05
	
	
	children = get_child_count()
	
	if children > 0:
		for i in range(children):
				get_child(i-1).set_surface_override_material(0,get_surface_override_material(0))
				pass
	if children > 0:
			first_childs_child = get_child(0).get_child_count()
	
	if first_childs_child > 0:
			scale_to_scale_v2 = Vector2(get_child(0).get_child(0).scale.x,get_child(0).get_child(0).scale.z)
			get_child(0).get_child(0).set_surface_override_material(0,unique_plane_cover_material)
			get_child(0).get_child(0).get_surface_override_material(0).set_shader_parameter("scale_to_scale",scale_to_scale_v2 )
			if get_viewport().get_camera_3d().position.y < 0:
				get_child(0).get_child(0).set_surface_override_material(0,material2)
			if get_viewport().get_camera_3d().position.y > 0:
				get_child(0).get_child(0).set_surface_override_material(0,unique_plane_cover_material)
	
	
	if camera_3D == "<Object#null>" or camera_3D == "<null>" :
		set_surface_override_material(0,material)
		get_active_material(0).set_shader_parameter("vertex_cords_animating_data_texture", texture)
		
