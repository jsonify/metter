extends StaticBody2D

class_name GroundButton

onready var animated_sprite := $AnimatedSprite
onready var unpressed_collision := $UnpressedCollision
onready var pressed_collision := $PressedCollision

var is_button_pressed := false

func press_button():
	is_button_pressed = true
	unpressed_collision.set_deferred("disabled", true)
	pressed_collision.set_deferred("disabled", false)
	animated_sprite.play("Pressed")
	

func unpress_button():
	is_button_pressed = false
	unpressed_collision.set_deferred("disabled", false)
	pressed_collision.set_deferred("disabled", true)
	animated_sprite.play("Unpressed")


func _on_PressDetector_body_entered(body: Node) -> void:
	if body is RigidBox or body is Player:
		if is_button_pressed == false:
			press_button()


func _on_PressDetector_body_exited(body: Node) -> void:
	if body is RigidBox or body is Player:
		if is_button_pressed == true:
			unpress_button()
