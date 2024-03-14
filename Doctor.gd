extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$doctor.animation = "idle"
	$doctor.play($doctor.animation)
