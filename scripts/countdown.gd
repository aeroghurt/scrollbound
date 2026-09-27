extends Control


@onready var label: Label = $Label
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(20)


func _process(_delta: float) -> void:
	label.text = "%02d:%02d" % time_left()


func time_left():
	var time_left = timer.time_left
	var minutes = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minutes, seconds]
	

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
