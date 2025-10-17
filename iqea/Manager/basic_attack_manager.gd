extends Node2D

@onready var hitbox_component = $HitboxComponent
@onready var animation_player = $AnimationPlayer

@export var hit_damage: int

func _ready():
	hitbox_component.damage = hit_damage
	animation_player.play("RESET")

func _input(_event: InputEvent) -> void:
	var player = get_parent() as CharacterBody2D
	if not player is CharacterBody2D:
		return
	if Input.is_action_just_pressed("attack"):
		if not animation_player.is_playing():
			SoundEffectPlayer.set_track("res://Assets/sfx/jingles_Defeat.mp3")
		hitbox_component.damage = hit_damage
		animation_player.play("hit")
		self.rotation = player.global_position.angle_to_point(get_global_mouse_position())
