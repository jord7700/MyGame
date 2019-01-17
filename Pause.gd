extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var contMenu = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hide()
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if Input.is_action_just_pressed("ui_cancel"):
		if (get_tree().paused == false):
			show()
			$ControlsButton/Label.hide()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false
			
		
	pass

func _on_Resume_pressed():
	hide()
	get_tree().paused = false
	pass # replace with function body


func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_ControlsButton_pressed():
	if (contMenu == false):
		contMenu = true
		$Resume.hide()
	#$ControlsButton.hide()
		$ControlsButton.set_text("Exit")
		$Exit.hide()
		$ControlsButton/Label.show()
	else:
		contMenu = false
		$Resume.show()
	#$ControlsButton.hide()
		$ControlsButton.set_text("Controls")
		$Exit.show()
		$ControlsButton/Label.hide()
	pass # replace with function body