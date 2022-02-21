extends KinematicBody2D

var velocity = Vector2(0, 0)

var speed = 300;

#func _ready():
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left");
	velocity.y = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up");
	velocity = velocity.normalized();
	print(velocity)
	
	move_and_collide(velocity * speed * delta);
