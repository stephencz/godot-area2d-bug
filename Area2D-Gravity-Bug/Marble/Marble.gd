class_name Marble
extends RigidBody2D

var isTeleportQueued: bool = false
var isTeleportPrepared: bool = false
var isTeleportComplete: bool = false

var teleportPosition:Vector2 = Vector2(0, 0)
var teleportLinearVelocity: Vector2 = Vector2(0, 0)
var teleportAngularVelocity: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self._handle_teleport()

func _integrate_forces(state):
	if self.custom_integrator:
		self._teleport_marble(state)

func queue_teleport(newPosition: Vector2) -> void:
	self.isTeleportQueued = true
	self.teleportPosition = newPosition
	self.teleportLinearVelocity = self.linear_velocity
	self.teleportAngularVelocity = self.angular_velocity

func _handle_teleport() -> void:
	if self.isTeleportComplete:
		self._finish_teleport()
		
	else:	
		if self.isTeleportQueued:
			if not self.isTeleportPrepared:
				self._prepare_teleport()

func _prepare_teleport() -> void:
	self.set_use_custom_integrator(true)
	self.isTeleportPrepared = true
	
func _teleport_marble(state) -> void:
	var temp = state.get_transform()
	
	temp.origin  = Vector2(self.teleportPosition.x, self.teleportPosition.y)	
	state.set_transform(temp)

	self.isTeleportQueued = false
	self.isTeleportPrepared = false
	self.isTeleportComplete = true

func _finish_teleport() -> void:
	self.set_use_custom_integrator(false)
	self.isTeleportComplete = false
