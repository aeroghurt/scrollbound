extends SubViewportContainer

signal phone_toggled(is_open: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("phone"):
		visible != visible
		phone_toggled.emit(visible)
	
		if !visible:
			release_focus()
