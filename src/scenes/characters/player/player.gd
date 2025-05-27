extends CharacterBody2D

#Preloads
@onready var option_card = preload("res://src/scenes/ui/Level_up_panel/option_card.tscn")

@export var move_speed := 320.0
@export var acceleration := 10.0
@export var virtual_joystick: VirtualJoystick

@export var stats = {"attack": 10, "extra_projectiles": 0, "area": 10, "luck": 0,}
@export var available_stats = stats.duplicate()

func _process(delta):
	$Control/Area.text = "Area:" + str(stats["area"])
	$Control/EP.text = "EP:" + str(stats["extra_projectiles"])
	$Control/Attack.text = "Attack:" + str(stats["attack"])
	$Control/Luck.text = "Luck:" + str(stats["luck"])
	if Input.is_action_just_pressed("level_up"):
		level_up()

func level_up():
	$Control/Level_up_panel.visible = true
	var options = 0
	var max_options = 3
	available_stats = stats.duplicate()
	while options < max_options:
		var option = option_card.instantiate()
		$Control/Level_up_panel/Option_container.add_child(option)
		options += 1
	get_tree().paused = true
	
func upgrade_character(upgraded_stat, amount):
	stats[upgraded_stat] += amount
	var upgrade_options = $Control/Level_up_panel/Option_container.get_children()
	for i in upgrade_options:
		i.queue_free()
	$Control/Level_up_panel.visible = false
	get_tree().paused = false
