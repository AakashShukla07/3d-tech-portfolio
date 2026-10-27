extends Area3D

# This creates a slot in the Inspector so we can drag and drop our UI panel
@export var project_panel: Panel

func _ready():
	# This automatically listens for when the player walks in or out of the bubble
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	# If the object entering the bubble is our player, make the panel visible
	if body.name == "player":
		project_panel.visible = true

func _on_body_exited(body):
	# When the player walks away, hide the panel again
	if body.name == "player":
		project_panel.visible = false
