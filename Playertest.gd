extends KinematicBody2D

var velocity = Vector2(0, 0)

var speed = 300;

func _ready():
	velocity.x = Input.is_action_just_pressed("ui_left") - Input.is_action_just_pressed("ui_right");
	velocity.y = Input.is_action_just_pressed("ui_down") - Input.is_action_just_pressed("ui_up");
	velocity.normalize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
