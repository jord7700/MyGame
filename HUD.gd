extends CanvasLayer

signal start_game

var gameStart = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if (gameStart == false && Input.is_key_pressed(KEY_SPACE)):
		_on_StartButton_pressed()
		set_process(false)
	pass

func show_message(text):
	$VBoxContainer/VBoxCenter/MessageLabel.text = text
	$VBoxContainer/VBoxCenter/MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	set_process(true)
	gameStart = false
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$VBoxContainer/HBoxBottom/StartButton.show()
	$VBoxContainer/VBoxCenter/MessageLabel.text = "Dodge the\nCreeps!"
	$VBoxContainer/VBoxCenter/MessageLabel.show()
	
func update_score(score):
	$VBoxContainer/HBoxTop/HBoxContainer/ScoreLabel.text = str(score)

func update_highScore(highScore):
	$VBoxContainer/HBoxTop/HBoxContainer3/HighScore.text = str(highScore)

func update_level(level):
	$VBoxContainer/HBoxTop/HBoxContainer2/Level.text = str(level)
	
func updateProgressBar(progress):
	$VBoxContainer/HBoxLevelBar/TextureProgress.value = progress

func updateProgressBarMax(newMax):
	$VBoxContainer/HBoxLevelBar/TextureProgress.max_value = newMax

func _on_MessageTimer_timeout():
	$VBoxContainer/VBoxCenter/MessageLabel.hide()



func _on_StartButton_pressed():
	$VBoxContainer/HBoxBottom/StartButton.hide()
	gameStart = true
	set_process(true)
	emit_signal("start_game")
