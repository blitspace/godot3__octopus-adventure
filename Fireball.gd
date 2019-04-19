extends Area2D

signal gone

const SPEED = 600
var velocity = Vector2()
var direction = 1

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

	$Particles2D.rotation_degrees = $Particles2D.rotation_degrees * dir
	$Particles2D.position.x = $Particles2D.position.x * dir


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("gone")
	call_deferred("free")


func _on_Fireball_body_entered(body):
	if body.name != "Player":
		call_deferred("free")
		emit_signal("gone")
