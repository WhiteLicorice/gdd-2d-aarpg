class_name HitBox extends Area2D

signal damaged(damage: int)

func take_damage(damage: int):
	print("Damage: ", damage)
	damaged.emit(damage)
