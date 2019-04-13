extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
const ACCELARATION = 50
const MAX_SPEED = 200

const FIREBALL = preload("res://Fireball.tscn")

var is_attacking = false
var motion = Vector2()
var fireball_starting_position_x = null

func _ready():
	fireball_starting_position_x = $Position2D.position.x


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

	if Input.is_action_just_pressed("ui_focus_next") and not is_attacking:
		is_attacking = true
		var dir = sign($Position2D.position.x)
		if $Sprite.is_playing() and $Sprite.animation == "run":
			$Position2D.position.x = (fireball_starting_position_x * 2) * dir
		else:
			$Position2D.position.x = fireball_starting_position_x * dir

		var fireball = FIREBALL.instance()
		fireball.connect("fireball_gone", self, "test")

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


func test():
	is_attacking = false