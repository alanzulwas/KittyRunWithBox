extends Camera2D
class_name PanningCamera2D

export var _target_zoom: float = 1.5

const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 1.0
const ZOOM_RATE: float = 8.0

func zoom_in() -> void :
	_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)

func zoom_out() -> void :
	_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	set_physics_process(true)

func _unhandled_input(event: InputEvent) -> void :
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT:
			position -= event.relative * zoom

func _physics_process(delta: float)-> void:
	zoom = lerp(zoom,_target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx(zoom.x, _target_zoom))
