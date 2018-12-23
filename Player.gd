extends Area2D
signal hit

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	screensize = get_viewport_rect().size # Saves size of screen in pixels
	hide()
	
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta #updates sprtie's position
	position.x = clamp(position.x, 0, screensize.x) # limits sprite to inside the window
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
	pass


func _on_Player_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
