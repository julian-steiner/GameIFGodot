extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func start(var pos, var direction):
	self.position = pos;
	self.rotation = direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
