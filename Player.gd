extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
const ACCELARATION = 50
const MAX_SPEED = 200

const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2()

func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELARATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("run")
		if sign($Position2D.position.x) == -1:
			$Position2D.position *= -1
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELARATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("run")
		if sign($Position2D.position.x) == 1:
			$Position2D.position *= -1
	else:
		motion.x = 0
		$Sprite.play("idle")
		friction = true
	
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		
		fireball.set_fireball_direction(sign($Position2D.position.x))
		
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position

	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("jump")
		else:
			$Sprite.play("fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)


	motion = move_and_slide(motion, UP)
