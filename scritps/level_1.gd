extends Node2D

@export var enemies = 5
var current_batallion_count = 5

@onready var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	create_battalion(enemies)
		

func _on_player_rocked_launched():
	var rocket_instance = rocket_scene.instantiate()
	var time = Time.get_unix_time_from_system()
	rocket_instance.global_position = $Player.global_position
	rocket_instance.name = "Rocket@" + str(time)
	add_child(rocket_instance)

func create_enemy(x, y):
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = Vector2(x, y)
	enemy_instance.connect("enemy_defeated", enemy_defeated_signal)
	enemy_instance.get_node("ScreenNotifier").connect("screen_exited", lose)
	add_child(enemy_instance)
	return enemy_instance

func create_battalion(num):
	current_batallion_count = num
	var start_x = 0
	var distance = get_viewport_rect().size.y / (num + 1)
	for i in range(1, num + 1):
		start_x = get_viewport_rect().size.x - (randi() % 101)
		var instance = create_enemy(start_x, i * distance)
		instance.amplitude += (randi() % 30)
		instance.speed -= (randi() % 30)
		instance.name = "Enemy@" + str(i)  

func enemy_defeated_signal():
	current_batallion_count -= 1
	if current_batallion_count <= 0:
		create_battalion(enemies)

func lose():
	get_tree().paused = true
	$Message.text = "GAME OVER"
	$Message.visible = true
