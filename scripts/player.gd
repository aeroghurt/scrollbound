extends CharacterBody2D
class_name Player

@export_category("Stats")
@export var current_speed: int = 400
@export var base_speed: int = 400
@export var sprint_speed: int = 550

@export var phone = "/PhoneSubViewportContainer"

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]

const IS_MOVING = "parameters/conditions/is_moving"

var last_direction := Vector2.DOWN
var input_dir: Vector2
var is_phone_open: bool = false

func _ready() -> void:
	animation_tree.set_active(true)
	animation_playback.travel("idle")
	
	if phone:
		phone.phone_toggled.connect(_on_phone_toggled)


func _on_phone_toggled(open: bool) -> void:
	is_phone_open = open
	if is_phone_open:
		input_dir = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if input_dir.length_squared() > 0.01:
		velocity = input_dir.normalized() * current_speed
		last_direction = input_dir.normalized()
		
		if Input.is_action_pressed("left"):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
			
		if Input.is_action_pressed("sprint"):
			current_speed = sprint_speed
		else:
			current_speed = base_speed

		animation_tree.set("parameters/walk/blend_position", last_direction)
		animation_tree.set(IS_MOVING, true)
		animation_playback.travel("walk")
	else:
		velocity = Vector2.ZERO
		animation_tree.set(IS_MOVING, false)
		animation_tree.set("parameters/idle/blend_position", last_direction)
		animation_playback.travel("idle")
		
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if is_phone_open:
		return
	input_dir = Input.get_vector("left", "right", "up", "down")
