extends Area2D

@export var teleportDestination: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self.handle_marble_teleport)


func handle_marble_teleport(body):
	if self.teleportDestination !=  null:
		if body is Marble:
			print("eleportin")
			body.queue_teleport(teleportDestination.position)
