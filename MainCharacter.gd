extends KinematicBody2D

var velocity = Vector2(0, 0)
var Bullet = preload("res://Bullet.tscn")

var speed = 200;
var angle = 0;
var turn_speed = PI;

var weapon = "pistol"
var state = "walk"
#func _ready():
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	velocity = velocity.normalized();
	if (velocity.length() == 0):
		state = "idle";
	else:
		state = "walk";
		
	if (Input.is_action_just_pressed("shoot")):
		var bullet = Bullet.instance();
		
		get_parent().add_child(bullet);
	
	$AnimatedSprite.play(state + "_" + weapon);
	
	angle = $AnimatedSprite.get_angle_to(get_global_mouse_position());
	
	if (abs(angle) <= turn_speed * delta):
		$AnimatedSprite.rotate(angle)
	
	else:
		$AnimatedSprite.rotate(turn_speed * delta * sign(angle));
	
	move_and_collide(velocity * speed * delta);
