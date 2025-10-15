class_name HurtBox extends Area2D

@export var damage: int = 1

func _ready():
	area_entered.connect(enter_area)
	pass
	
func enter_area(area: Area2D) -> void:
	if(area is HitBox):
		area.take_damage(damage)
		
