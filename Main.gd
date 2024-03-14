extends Node2D

var messages = [
	"Go up my child",
	"I've failed to turn you into a doctor",
	"Instead you're an aberration",
	"Stuck in an endless loop",
	"Find an exit to return to a body",
	"Good luck",
	"By the way your 60 seconds have already started",
	"I'm just here faffing about",
	"Have you ever",
	"Wait nevermind",
	"Hopefully you can get out of this somebody",
	"Soon it will only be a fleeting memory to me",
	"A bit morbid but oh well",
	
] 

var typing_speed = .02
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0


var TimeLeft = 60
@onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(1)
	timer.start()
	start_dialogue()


func stop_dialogue():
	remove_child($DoctorText)
	remove_child($next_char)
	remove_child($next_message)
	
	

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$DoctorText.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()


func _on_timer_timeout():
	TimeLeft -= 1 
	if TimeLeft == 0:
		get_tree().change_scene_to_file("res://Main.tscn")
	
