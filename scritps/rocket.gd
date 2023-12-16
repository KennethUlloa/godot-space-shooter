extends Area2D

@export var speed = 360

func _physics_process(delta):
	global_position.x += speed * delta

func _on_screen_exited():
	queue_free()
