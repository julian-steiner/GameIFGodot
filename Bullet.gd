extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 100000;
var velocity = Vector2(0, 0);

func start(var pos, var direction):
	self.position = pos;
	self.rotation = direction;
	velocity = Vector2(speed, 0).rotated(direction)

func _process(delta):
	move_and_slide(velocity * delta);
	if (move_and_collide(velocity * delta)):
		queue_free();
