extends Node

export (PackedScene) var Mob
var score
var highScore
var speedOffset
const SAVE_PATH = "res://save.json"


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	load_game()
	speedOffset = 0
	$HUD.update_highScore(highScore)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func game_over():
	#save_game()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PowerSpawnTimer.stop()
	$HUD.show_game_over()
	if score > highScore:
		highScore = score
	$HUD.update_highScore(highScore)
	$PowerUp.hide()
	save_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$PowerSpawnTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_MobTimer_timeout():
    # Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
    # Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
    # Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
    # Choose the velocity.
	if speedOffset == 1:
		mob.set_linear_velocity(Vector2(rand_range(mob.min_speed / 2, mob.max_speed / 2), 0).rotated(mob.rotation))
	else: 
		mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func save():
	var save_dict = highScore
	return save_dict
	
func save_game():
	#get save data from persistent nodes
	var save_dict = save()
	# create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	#serialize the data fictionary to JSON
	save_file.store_line(str(save_dict))
	save_file.close()
	pass
	
	# Note: This can be called from anywhere inside the tree. This function is path independent.
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return
	
	save_game.open(SAVE_PATH, File.READ)
	var data = save_game.get_line()
	highScore = int(data)
	save_game.close()

func _on_PowerUp_pickUp():
	speedOffset = 1
	for i in range(0, get_child_count()):
		var m = get_child(i)
		if (m.get_class() == "RigidBody2D"):
			m.set_linear_velocity(Vector2(m.linear_velocity[0] / 2, m.linear_velocity[1]))
	

func _on_PowerUp_timeOut():
	speedOffset = 0
	$PowerSpawnTimer.start()
	

func _on_PowerSpawnTimer_timeout():
	var pos = Vector2(rand_range(0, $Player.screensize.x - 1), rand_range(0, $Player.screensize.y - 1))
	$PowerUp.spawn(pos)
