extends Node

signal current_money_changed()

var current_money: int = 0:
	set(new_money):
		current_money = new_money
		current_money_changed.emit()

var button_property: Dictionary = {
	"DaButton1": {
		"coef": 1.10,
		
		"lvl": 1,
		"earn": 10,
		"up_cost": 100,
		},
		
	"DaButton2": {
		#multiplier:
		"coef": 1.20,
		#upgrade :
		"lvl": 1,
		"earn": 100,
		"up_cost": 1000,
		#cooldown:
		"cd_lvl": 1,
		"cooldown": 3.0,
		"cd_cost": 1100,
		#unlock:
		"unlock_cost": 100
	},
	
	"DaButton3": {
		#multiplier:
		"coef": 1.20,
		#upgrade :
		"lvl": 1,
		"earn": 1000,
		"up_cost": 2000,
		#cooldown:
		"cd_lvl": 1,
		"cooldown": 3.0,
		"cd_cost": 1100,
		#unlock:
		"unlock_cost": 200 #to change
	}
}
