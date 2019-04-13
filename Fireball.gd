extends Area2D

signal fireball_gone

const SPEED = 400
var velocity = Vector2()
var direction = 1

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	call_deferred('free')
	emit_signal("fireball_gone")


func _on_Fireball_body_entered(body):
	if body.name != "Player":
		call_deferred('free')
		emit_signal("fireball_gone")
