extends KinematicBody2D

class Weapon:
	var reload_time;
	var mag_capacity;
	var cooldown_time;
	var reloading;
	var mag_capacity_current;
	
	var cooldown = 0;
	
	func shoot():
		mag_capacity_current -= 1;
		cooldown = cooldown_time;
	func can_shoot() -> bool:
		print(cooldown)
		return cooldown == 0;
	func getSpriteName() -> String:
		return "weapon"
	func reload() -> void:
		cooldown = reload_time;
		reloading = true;
	func update_cooldown(delta) -> void:
		if (mag_capacity_current <= 0 && !reloading):
			reload();
		if (cooldown <= 0):
			cooldown = 0;
			if (reloading):
				reloading = false;
				mag_capacity_current = mag_capacity;
		else:
			cooldown -= delta;
			
class Pistol extends Weapon:
	func _init():
		cooldown_time = 0.5;
		mag_capacity = 10;
		mag_capacity_current = 10;
		reload_time = 1;
	func getSpriteName() -> String:
		return "pistol";
		
class Rifle extends Weapon:
	func _init():
		cooldown_time = 0.1;
		mag_capacity = 10;
		mag_capacity_current = 10;
		reload_time = 5;
	func getSpriteName() -> String:
		return "rifle"

var velocity = Vector2(0, 0)
var Bullet = preload("res://Bullet.tscn")

var speed = 200;
var angle = 0;
var turn_speed = PI;

var weapon : Weapon = Rifle.new();
var state = "walk"

func _process(delta):
	handle_shooting(delta);
	handle_movement(delta);
	handle_animations(delta);
	
func handle_shooting(var delta):
	if (Input.is_action_pressed("shoot") && weapon.can_shoot()):
		weapon.shoot();
		var bullet = Bullet.instance();
		bullet.start($Muzzle.global_position, rotation);
		get_parent().add_child(bullet);
	weapon.update_cooldown(delta)
	
func handle_walking(var delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	velocity = velocity.normalized();
	if (velocity.length() == 0):
		state = "idle";
	else:
		state = "walk";
	move_and_collide(velocity * speed * delta);
	
func handle_turning(var delta):
	angle = get_angle_to(get_global_mouse_position());
	if (abs(angle) <= turn_speed * delta):
		self.rotate(angle)
	else:
		self.rotate(turn_speed * delta * sign(angle));
	
func handle_movement(var delta):
	handle_walking(delta);
	handle_turning(delta);
	
func handle_animations(var delta):
	$AnimatedSprite.play(state + "_" + weapon.getSpriteName());

func hit():
	pass
