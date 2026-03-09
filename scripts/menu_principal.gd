extends Control
class_name MainMenu
const MUNDO = preload("uid://vrkq8jja8rek")
@onready var button: Button = $Button
@onready var quit: Button = $Quit
const UI = preload("uid://3il5gddt22vr")


func _ready() -> void:
	button.pressed.connect(_go_to_main)
	quit.pressed.connect(_quit_game)

func _quit_game():
	get_tree().quit()

func _transition_to(target : PackedScene):
	get_tree().change_scene_to_packed(target)

func _go_to_main():
	_transition_to(MUNDO)
