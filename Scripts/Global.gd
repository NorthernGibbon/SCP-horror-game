extends Node

var player
var computer
var is_sitting
var light_energy_value = 0
var hide_crosshair
var FrequencyAlignmentCounter = 0
var can_rotate = true
var task_completed = 0

# Lore booleans
var paper_lore_1_collision = false

#Room Booleans
var is_in_office
var is_in_archives 
var is_in_corridor
var is_in_lab

signal frequency_updated

func register_player(in_player):
	player = in_player

func register_variabel(in_sitting):
	is_sitting = in_sitting

func register_computer(in_computer):
	computer = in_computer

func increase_Frequency_counter():
	FrequencyAlignmentCounter += 1
	emit_signal("frequency_updated", FrequencyAlignmentCounter)
