extends StaticBody3D

signal body_entered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite3D.play("idle_down")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("a3d body entered")
	body_entered.emit(body)
