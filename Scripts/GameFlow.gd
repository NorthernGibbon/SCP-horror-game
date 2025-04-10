extends Node

@onready var archives: AudioStreamPlayer3D = $"../SoundsForGameLoop/Archives"

# Objects to hide or show
@onready var box_to_fall: Node3D = $"../Enviroment/Archives/Misc/box_to_fall"
@onready var box_fallen: Node3D = $"../Enviroment/Archives/Misc/box_to_fall2"
@onready var paper_lore_1: Node3D = $"../Enviroment/Archives/Misc/Paper_Lore#1"


var milestone = 1000

func _ready() -> void:
	box_fallen.hide()

func _process(_delta: float) -> void:
	handle_milestone()

func handle_milestone():
	var milestone_updated = true 

	while milestone_updated:  
		milestone_updated = false  
		# Each day maybe 5 mins or 10 mins.
		# 
		
		match milestone:
			1000:
				# DAY 1
				if Global.FrequencyAlignmentCounter == 2 and Global.is_in_office:
					# Just tasks on day 1 except 1 light off
					Global.light_energy_value = 0
					
					milestone = 1100
					milestone_updated = true
					# There should be some more tasks here
					
			1100:
				if Global.FrequencyAlignmentCounter == 3 and Global.is_in_corridor:
					# Reset players location and show a screen that says day 2
					print("Phase 2 Day 1")
					 
					milestone = 2000
					milestone_updated = true
					Global.FrequencyAlignmentCounter = 0
			2000:
				# Day 2
				# First lore the player gets, should be vague but still interesting
				if Global.FrequencyAlignmentCounter == 2 and Global.is_in_office:
					#Box falling sound
					archives.play()
					
					# Remove previous box 
					box_to_fall.hide()
					
					# Show new box and paper
					box_fallen.show()
					paper_lore_1.show()
					Global.paper_lore_1_collision = true
					
					milestone = 2100
					milestone_updated = true 
					
			2100:
				if Global.FrequencyAlignmentCounter == 3 and Global.is_in_office:
					milestone = 3000
					milestone_updated = true 
					Global.FrequencyAlignmentCounter = 0
					box_to_fall.show()
					box_fallen.hide()
					paper_lore_1.hide()
					Global.paper_lore_1_collision = false
					# We need to make the player go into the corridor
					
			3000:
				#Global.FrequencyAlignmentCounter = 0
				# Day 3
				pass
