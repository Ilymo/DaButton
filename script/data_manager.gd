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
		"coef": 1.10,
		
		"lvl": 1,
		"earn": 10,
		"up_cost": 10,
		"theme": preload("res://asset/stylebox/DaButton1/theme1.tres")
		},
		
	"DaButton2": {
		#multiplier:
		"coef": 1.20,
		#upgrade :
		"lvl": 1,
		"earn": 20,
		"up_cost": 200,
		#cooldown:
		"cd_lvl": 1,
		"cooldown": 3.0,
		"cd_cost": 1100,
		#unlock:
		"unlock_cost": 100,
		"theme": preload("res://asset/stylebox/DaButton2/theme2.tres")
	},
	
	"DaButton3": {
		#multiplier:
		"coef": 1.20,
		#upgrade :
		"lvl": 1,
		"earn": 300,
		"up_cost": 3000,
		#cooldown:
		"cd_lvl": 1,
		"cooldown": 3.0,
		"cd_cost": 1100,
		#unlock:
		"unlock_cost": 300, #to change
		"theme": preload("res://asset/stylebox/DaButton3/theme3.tres")
	},
	
	"DaButton4": {
		#multiplier:
		"coef": 1.20,
		#upgrade :
		"lvl": 1,
		"earn": 400,
		"up_cost": 4000,
		#cooldown:
		"cd_lvl": 1,
		"cooldown": 3.0,
		"cd_cost": 4100,
		#unlock:
		"unlock_cost": 400, #to change
		"theme": preload("res://asset/stylebox/DaButton4/theme4.tres")
	}
}
