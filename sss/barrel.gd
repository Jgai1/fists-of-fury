extends StaticBody2D

@onready var damege_receiver: DamegeReceiver = $DamegeReceiver
@export var knockback_intensity :float
@onready var sprite_2d: Sprite2D = $Sprite2D

const GRAVITY := 600.0

var height := 0.0
var height_speed := 0.0
var velocity := Vector2.ZERO
enum State {IDLE, DESTROYED}
var state := State.IDLE
func _ready() -> void:
	damege_receiver.damage_received.connect(on_receive_damage.bind())

func _process(delta: float) -> void:
	position += velocity * delta 
	sprite_2d.position =Vector2.UP * height
	handle_air_time(delta)
func on_receive_damage(_damage: int,direction:Vector2) -> void:
	if state == State.IDLE:
		sprite_2d.frame = 1
		height_speed = knockback_intensity * 2
		state = State.DESTROYED
	velocity = direction * knockback_intensity



func handle_air_time(delta: float) -> void:
	if state == State.DESTROYED:
		modulate.a -= delta
		height += height_speed * delta
		if height < 0:
			height = 0
			queue_free()
		else :
			height_speed -= GRAVITY * delta
