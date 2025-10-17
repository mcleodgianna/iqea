extends CharacterBody2D


@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent
@export var id = 0

func _ready():
	$HurtboxComponent.hit.connect(on_hit)

func set_max_health(hp:int):
	health_component.max_health = hp

func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign,1)


func on_hit():
	velocity_component.take_knockback_away_from_player()
