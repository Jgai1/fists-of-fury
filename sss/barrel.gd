extends StaticBody2D

@onready var damege_receiver: DamegeReceiver = $DamegeReceiver
@export var knockback_intensity :float
var velocity := Vector2.ZERO
func _ready() -> void:
	damege_receiver.damage_received.connect(on_receive_damage.bind())

func _process(delta: float) -> void:
	position += velocity *delta
func on_receive_damage(_damage: int,direction:Vector2) -> void:
	velocity = direction * knockback_intensity
