extends RigidBody2D
class_name Beer


func _on_body_entered(_body: Node) -> void:
	queue_free()
