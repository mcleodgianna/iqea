extends CharacterBody2D


@onready var health_component = $HealthComponent
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent
@onready var animated_sprite_2d = $Visuals/AnimatedSprite2D
@onready var footstep_player = $FootstepPlayer

var number_colliding_bodies = 0
var base_speed = 0

func _ready():
	base_speed = velocity_component.max_speed
	
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	
	


#func set_stats():


func _process(_delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	if movement_vector.length() > 0:
		if not footstep_player.playing:
			footstep_player.play()
	else:
		footstep_player.stop()
	
	var move_signx = sign(movement_vector.x)
	var move_signy = sign(movement_vector.y) 
	if move_signx != 0:
		visuals.scale = Vector2(move_signx,1)
	if abs(direction.x) < 0.5:
		print(movement_vector)
		if direction.y > .1:
			animated_sprite_2d.play("walk_down")
		elif direction.y < -.1:
			animated_sprite_2d.play("walk_up")
		else:
			if move_signy >0:
				animated_sprite_2d.play("idle_front")
			else:
				animated_sprite_2d.play("idle_back")
	else:
		animated_sprite_2d.play("")

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement,y_movement)

func check_deal_damage():
	if number_colliding_bodies == 0 || (!damage_interval_timer.is_stopped()):
		return
	health_component.damage(1)
	print("ow: " + str(health_component.current_health))
	damage_interval_timer.start()


func on_body_entered(_other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(_other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	pass
	#$HitRandomStreamPlayer.play_random()
