extends KinematicBody2D

signal game_over

var run_speed = 300
var jump_speed = -500
var gravity = 600

var velocity = Vector2()
var jumping = false

var right = true
var jump = true


func get_input():
	velocity.x = 0
	if rand_range(0, 1e2) < 1:
		right = !right
	jump = rand_range(0, 10) < 1

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		$SpriteGuy.set_flip_h(true)
	else:
		$SpriteGuy.set_flip_h(false)
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "TileMap":
			continue
		if "Guy" == collision.collider.name:
			emit_signal("game_over")
