extends CharacterBody2D

@export_category("Stats")
@export var speed: int = 250

var input_dir: Vector2


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if input_dir.length_squared() > 0.01:
		velocity = input_dir.normalized() * speed
	move_and_slide()


func _input(_event: InputEvent) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
