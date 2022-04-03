extends Node2D

export (int) var clones = 10
export (int) var time_between_clones = 1

var count_clones = 0
var elapsed_time_from_last_drop = 0

var Clone = load("res://GuyClone.tscn")
var Guy = load("res://Guy.tscn")

var drop_clones = false
var music_on = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !drop_clones:
		return
	
	elapsed_time_from_last_drop += delta
	if elapsed_time_from_last_drop > time_between_clones:
		elapsed_time_from_last_drop = 0
		instance_clone()
		count_clones += 1
		$HUD.update_score(count_clones)

func instance_guy():
	var guy = Guy.instance()
	guy.connect("game_over", self, "_on_game_over")
	add_child(guy)

func instance_clone():
		var clone = Clone.instance()
		clone.position.x = rand_range(0, 1000)
		clone.connect("game_over", self, "_on_game_over")
		add_child(clone)

func reset_game():
	elapsed_time_from_last_drop = 0
	count_clones = 0
	$HUD.update_score(count_clones)	

func new_game():
	instance_guy()
	reset_game()
	drop_clones = true

func game_over():
	print_debug("Game Over")
	drop_clones = false
	
	if music_on:
		$GOAudio.play()
	
	for c in get_children():
		if "Guy" in c.name:
			remove_child(c)
			c.queue_free()

	$HUD.game_over(count_clones)

func _on_game_over():
	game_over()

func _on_HUD_start_game():
	new_game()

# Music ON/OFF
func _on_HUD_switch_music():
	if music_on:
		$Music.volume_db = -120
	else:
		$Music.volume_db = -15
	
	music_on = !music_on
