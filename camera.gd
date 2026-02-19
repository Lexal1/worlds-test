extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
@export var LOOKAROUND_SPEED = 0.005
var rot_x = 0
var rot_y = 0
func _input(event):
	if event is InputEventMouseMotion and event.button_mask & 1:
		#rot_x += event.relative.x * LOOKAROUND_SPEED
		#rot_y += event.relative.y * LOOKAROUND_SPEED
		transform.basis = Basis()
		get_parent().rotate_object_local(Vector3(0, 1, 0), event.relative.x * LOOKAROUND_SPEED)
		#get_parent().rotate_object_local(Vector3(1, 0, 0), event.relative.y * LOOKAROUND_SPEED) #rot_y
		
