extends Node

@onready var money_label: RichTextLabel = %MoneyLabel

var current_money: int = 10


func _ready() -> void:
	set_money(current_money)
	
	
func set_money(money_earn) -> void:
	current_money = money_earn
	money_label.text = "$ " + str(current_money)
