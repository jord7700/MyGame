extends Area2D
signal pickUp
signal timeOut
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hide()

#func _process(delta):
#	pass

func spawn(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_PowerUp_area_shape_entered(area_id, area, area_shape, self_shape):
	$Timer.start()
	emit_signal("pickUp")
	hide()
	$CollisionShape2D.disabled = true


func _on_Timer_timeout():
	emit_signal("timeOut")
	#queue_free()