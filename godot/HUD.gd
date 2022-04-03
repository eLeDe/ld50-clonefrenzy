extends CanvasLayer

signal start_game
signal switch_music

var music_on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Menu_pressed()

func _on_Start_pressed():
	$Score.show()
	$Message.hide()
	$Start.hide()
	$Instructions.hide()
	$Credits.hide()
	$Menu.hide()
	
	emit_signal("start_game")


func update_score(score):
	$Score.text = "Clones: " + str(score)
	
func game_over(score):
	$Message.text = "Game Over\nScore: " + str(score) + " clones"
	$Message.show()
	$Controls.hide()
	$Start.text = "Play again"
	$Start.show()
	$Menu.show()


func _on_Menu_pressed():
	$Score.hide()
	$Message.text = "CloneFrenzy"
	$Message.show()
	$Controls.hide()
	$Start.text = "Play"
	$Start.show()
	$Instructions.show()
	$Credits.show()
	$Menu.hide()


func _on_Instructions_pressed():
	$Message.text = "Skip the clones as long as you can"
	$Message.show()
	$Controls.show()
	$Start.hide()
	$Instructions.hide()
	$Credits.hide()
	$Menu.show()


func _on_Credits_pressed():
	$Message.text = "Made by eLeDe for LudumDare #50 - Compo\n\nDelay the inevitable"
	$Message.show()
	$Controls.hide()
	$Start.hide()
	$Instructions.hide()
	$Credits.hide()
	$Menu.show()	


func _on_MusicSwitch_pressed():
	if music_on:
		$MusicSwitch.text = "Music OFF"
	else:
		$MusicSwitch.text = "Music ON"
	music_on = !music_on
	emit_signal("switch_music")
