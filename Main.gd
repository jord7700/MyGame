extends Node

export (PackedScene) var Mob
var score
var highScore
const SAVE_PATH = "res://save.json"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	load_game()
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
	$HUD.show_game_over()
	if score > highScore:
		highScore = score
	$HUD.update_highScore(highScore)
	save_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
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











