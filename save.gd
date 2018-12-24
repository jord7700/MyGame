"""extends Node

signal SAVE

const SAVE_PATH = "res://save.json"

func _ready():
	load_game()

func save_game():
	#get save data from persistent nodes
	var save_dict= {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	# create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	#serialize the data fictionary to JSON
	save_file.store_line(save_dict.to_json())
	emmit_signal(SAVE)
	pass

func load_game():
	
	"""