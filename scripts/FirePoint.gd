@tool
class_name FirePoint
extends Marker2D

@export var sprite : AnimatedSprite2D;

var _get_position : Callable = func(): return Vector2.ZERO;
var _get_rotation : Callable = func(): return 0.0;

func _ready():
	sprite.frame_changed.connect(on_sprite_frame_changed);
	sprite.animation_changed.connect(update_position);
	update_position();
func on_sprite_frame_changed():
	position = _get_position.call();
	rotation_degrees = _get_rotation.call();

func update_position():
	match sprite.animation:
		"idle":
			_get_position = get_idle_position;
			_get_rotation = get_default_rotation;
		"run":
			_get_position = get_run_position;
			_get_rotation = get_default_rotation;
		"jump":
			_get_position = get_jump_position;
			_get_rotation = get_default_rotation;
		"fall":
			_get_position = get_jump_position;
			_get_rotation = get_default_rotation;
		"crouch":
			_get_position = get_crouch_position;
			_get_rotation = get_default_rotation;
		"death":
			_get_position = get_death_position;
			_get_rotation = get_death_rotation;
	on_sprite_frame_changed();

func get_default_rotation():
	return 0.0;
func get_death_rotation():
	var positions : Array[float] = [
		0.0, 
		0.0, 
		30.0,
		0.0,
		-5.0,
		0.0,
		0.0,
		0.0
	];
	return positions[sprite.frame];
func get_death_position():
	var positions : Array[Vector2] = [
		Vector2(14, -1), 
		Vector2(16, 2), 
		Vector2(14, 9),
		Vector2(13, 2),
		Vector2(8, 2),
		Vector2(10, 15),
		Vector2(10, 12),
		Vector2(10, 13)
	];
	return positions[sprite.frame];
func get_idle_position():
	return Vector2(13, -2 if sprite.frame <= 2 else -1);
func get_run_position():
	var positions : Array[int] = [-3, -5, -2, -4, -5, -2];
	return Vector2(13, positions[sprite.frame]);
func get_jump_position():
	return Vector2(14, -2);
func get_crouch_position():
	var positions : Array[Vector2] = [
		Vector2(13, -2), 
		Vector2(13, -1), 
		Vector2(14, 2)
	];
	return positions[sprite.frame];
