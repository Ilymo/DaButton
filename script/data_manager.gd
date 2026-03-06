extends Node

signal current_money_changed()

var current_money: int = 0:
	set(new_money):
		current_money = new_money
		current_money_changed.emit()

#target index use at sufix to generate unlock button
var target_index: int = 2
#maximum unlockable button
var max_target_index: int = 4

var button_property: Dictionary = {
	"DaButton1": {
		"coef": 1.005,
		
		"lvl": 1,
		"earn": 20,
		"up_cost": 30,
		"theme": preload("res://asset/stylebox/DaButton1/theme1.tres"),
		"sound": preload("res://asset/audio/click_002.ogg")
		},
		
	"DaButton2": {
		"label": "Betta Button",
		#multiplier:
		"coef": 1.015,
		#upgrade :
		"lvl": 1,
		"earn": 1000,
		"up_cost": 1000,
		#cooldown:
		"cd_lvl": 1,
		"max_cd_lvl": 10,
		"cooldown": 10.0,
		"initial_cd": 10.0,
		"cd_cost": 100000,
		#unlock:
		"unlock_cost": 50000,
		"theme": preload("res://asset/stylebox/DaButton2/theme2.tres"),
		"sound": preload("res://asset/audio/select_001.ogg")
	},
	
	"DaButton3": {
		"label": "Supa Button",
		#multiplier:
		"coef": 1.04,
		#upgrade :
		"lvl": 1,
		"earn": 10000,
		"up_cost": 10000,
		#cooldown:
		"cd_lvl": 1,
		"max_cd_lvl": 10,
		"cooldown": 20.0,
		"initial_cd": 20.0,
		"cd_cost": 250000,
		#unlock:
		"unlock_cost": 500000, #to change
		"theme": preload("res://asset/stylebox/DaButton3/theme3.tres"),
		"sound": preload("res://asset/audio/drop_001.ogg")
	},
	
	"DaButton4": {
		"label": "Giga Button",
		#multiplier:
		"coef": 1.07,
		#upgrade :
		"lvl": 1,
		"earn": 100000,
		"up_cost": 100000,
		#cooldown:
		"cd_lvl": 1,
		"max_cd_lvl": 10,
		"cooldown": 30.0,
		"initial_cd": 30.0,
		"cd_cost": 500000,
		#unlock:
		"unlock_cost": 2000000, #to change
		"theme": preload("res://asset/stylebox/DaButton4/theme4.tres"),
		"sound": preload("res://asset/audio/drop_004.ogg")
	},
	
	"DaFinal": {
		"unlock_cost": 2000000,
		"cost": 40000000
	}
}
