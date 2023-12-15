extends CharacterBody2D

@export var speed = 400
@export var sprite_size = 50

func _physics_process(delta):
	#velocity = Vector2(speed,0)
	#move_and_slide()
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		velocity += Vector2(0, -speed)
		
	if Input.is_action_pressed("move_down"):
		velocity += Vector2(0, speed)
	
	if Input.is_action_pressed("move_right"):
		velocity += Vector2(speed, 0)
	
	if Input.is_action_pressed("move_left"):
		velocity += Vector2(-speed, 0)
		
	var size = get_viewport_rect().size
	
	global_position = global_position.clamp(
		Vector2(sprite_size, sprite_size), 
		Vector2(size.x - sprite_size, size.y - sprite_size))
	
	#global_position.x = clamp(global_position.x, 0, size.x)
	#global_position.y = clamp(global_position.y, 0, size.y)
	
	move_and_slide()
