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
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	set_process(true)
	gameStart = false
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()



func _on_StartButton_pressed():
	$StartButton.hide()
	gameStart = true
	set_process(true)
	emit_signal("start_game")
