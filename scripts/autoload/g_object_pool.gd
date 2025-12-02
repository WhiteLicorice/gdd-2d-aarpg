class_name GNodePool_ extends Node

# StringName is a unique string: comparing 2 StringNames with the same value will always return True.
# This is a dictionary of StringName:Array<T>
# Weakly typed because Godot does not enforce nested typing yet.
var pools: Dictionary[StringName, Array] = {}

## Gets an instance of a type living in its bucket.
## To simplify behavior, returns null if no object is in the pool.
## Caller must handle this case.
func get_obj(obj_type: StringName) -> Node:
	if !has_pool(obj_type):
		print_debug("GNodePool_: no pool of % type yet in get_obj, instantiating..." % obj_type)
		pools[obj_type] = []
	var obj = pools[obj_type].pop_back()
	print_debug("GNodePool_: get_obj returning %s" % obj)
	return obj

## Puts an instance of a type into its pool.
func put_obj(obj_type: StringName, obj: Node):
	if !has_pool(obj_type):
		print_debug("GNodePool_: no pool of %s type yet in put_obj, instantiating..." % obj_type)
		pools[obj_type] = []
	print_debug("GNodePool_: put_obj iserting %s into %s" % [obj, obj_type])
	pools[obj_type].append(obj)

## Checks whether the pool for a specific object has been instantiated.
func has_pool(obj_type: StringName) -> bool:
	var exists: bool = (pools.get(obj_type)) != null
	print_debug("GNodePool_: pool of %s exists? %s." % [obj_type, exists])
	return exists

## Cleanses a specific pool to prevent memory leaks.
func cleanse_pool(obj_type: StringName):
	if !has_pool(obj_type):
		print_debug("GNodePool_: no pool of %s type in cleanse_pool!" % obj_type)
		return
	var pool: Array[Node] = pools[obj_type]
	for obj in pool:
		print_debug("GNodePool_: queueing %s of %s type to free." % [obj, obj_type])
		obj.queue_free()

## Cleanses all pools: useful when transitioning to another scene.	
func cleanse_all_pools():
	for obj_type in pools: # this iterates over keys, no tuple unpacking like in Python
		print_debug("GNodePool_: cleansing all pools...")
		cleanse_pool(obj_type)
	
