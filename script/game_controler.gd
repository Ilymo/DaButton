extends Control

@export var money: Label
@onready var da_button_container: VBoxContainer = $DaButtonContainer
@onready var upgrade_container: VBoxContainer = $UpgradeContainer


const DA_BUTTON = preload("uid://ciaenivvk8sw2")
const COOLDOWN_BUTTON = preload("uid://cyr6d0wqdib7h")
const UP_GRADE_BUTTON = preload("uid://cqrajr3fhs77e")
const UNLOCK_BUTTON = preload("uid://c68m3ocduotos")


func update_money(amount: int) -> void:
	DataManager.current_money = amount
	money.text = str(DataManager.current_money)


#on da button pressed: current_money - amount(=base_earn * lvl)
#update money with new money amount
func earn(button_pressed: String) -> void:
	var amount = (
		DataManager.button_property[button_pressed]["earn"] *
		DataManager.button_property[button_pressed]["lvl"]
		)
	var new_money = DataManager.current_money + amount
	update_money(new_money)
	

#on upgrade pressed: increase lvl in datamanager by 1 and update money
func upgrade_lvl(button_pressed: String) -> void:
	DataManager.button_property[button_pressed]["lvl"] += 1
	var new_money = DataManager.current_money - DataManager.button_property[button_pressed]["up_cost"]
	update_money(new_money)


#on upgrade pressed: update upgrade_cost in datamanager
func update_upgrade_cost(button_pressed: String):
	#new cost = base_cost * coef^lvl
	var new_cost = (
		DataManager.button_property[button_pressed]["up_cost"] *
		pow(DataManager.button_property[button_pressed]["coef"],
			DataManager.button_property[button_pressed]["lvl"])
	)
	DataManager.button_property[button_pressed]["up_cost"] = new_cost


#on cooldown button pressed: reduce cd by 1.0s(formule a définir) and update money
func upgrade_cd(button_pressed: String) -> void:
	DataManager.button_property[button_pressed]["cooldown"] -= 1.0
	var new_money = DataManager.current_money - DataManager.button_property[button_pressed]["cd_cost"]
	update_money(new_money)


#on cooldown button pressed: update cooldown_cost in datamanager
func update_cd_cost(button_pressed: String) -> void:
	#new cost = base_cost * coef^lvl
	var new_cost = (
		DataManager.button_property[button_pressed]["cd_cost"] *
		pow(DataManager.button_property[button_pressed]["coef"],
			DataManager.button_property[button_pressed]["cd_lvl"])
	)
	DataManager.button_property[button_pressed]["cd_cost"] = new_cost


#func that unlock new button by instanciate it and append to container
func unlock_dabutton(button_name: String) -> void:
	var new_dabutton = DA_BUTTON.instantiate()
	new_dabutton.target_button = button_name
	new_dabutton.text = button_name
	da_button_container.add_child(new_dabutton)


func unlock_upgrade_button(button_name: String) -> void:
	var new_upgrade_button = UP_GRADE_BUTTON.instantiate()
	var new_cooldown_button = COOLDOWN_BUTTON.instantiate()
	
	new_upgrade_button.target_button = button_name
	new_cooldown_button.target_button = button_name
	
	new_upgrade_button.text = "Upgrade" + button_name
	new_cooldown_button.text = "Reduce CD of " + button_name
	
	upgrade_container.add_child(new_upgrade_button)
	upgrade_container.add_child(new_cooldown_button)

#func unlock a voir, maybe use un index quelque pars
func next_unlock(button_name: String) -> void:
	var new_unlock_button = UNLOCK_BUTTON.instantiate()
	new_unlock_button.target_button = button_name
	new_unlock_button.text = "Unlock " + button_name
	upgrade_container.add_child(new_unlock_button)
