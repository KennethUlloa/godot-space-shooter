extends Area2D

@export var speed = 200
@export var amplitude = 50
var ship_number = 0

var direction = -1

signal enemy_defeated

func _physics_process(delta):
	var time = Time.get_unix_time_from_system()
	var y = sin(time) * amplitude * delta
	
	global_position.y += y
	global_position.x += direction * speed * delta	

func _on_area_entered(area):
	if area.name.begins_with("Rocket"):
		print(name, " died")
		emit_signal("enemy_defeated")
		queue_free()
