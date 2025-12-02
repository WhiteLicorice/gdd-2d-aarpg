class_name Plant extends Node2D

func _ready():
	$HitBox.damaged.connect(take_damage)
	
func take_damage(_damage: int) -> void:
	print_debug("Putting %s in object pool..." % self)
	get_parent().remove_child(self)
	GObjectPool.put_obj("Plant", self)
