extends KinematicBody2D

signal game_over

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2()
var jumping = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		$SpriteGuy.set_flip_h(true)
	if left:
		velocity.x -= run_speed
		$SpriteGuy.set_flip_h(false)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
		$AudioJump.play()

	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "TileMap":
			continue
		if "GuyClone" in collision.collider.name:
			emit_signal("game_over")
