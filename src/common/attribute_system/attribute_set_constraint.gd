class_name AttributeSetConstraint
extends RefCounted

var attributes: Dictionary[String, Attribute] = {}


func initialize_attribute_dependencies():
	printerr("this is a virtual func")


## 更改某一属性当前值之后的回调
func after_current_value_change(_attribute: StringName, _old_v: float, _new_v: float) -> void:
	printerr("this is a virtual func")


## 更改某一属性当前值之前的回调
func before_current_value_change(_attribute: StringName, _old_v: float, new_v: float) -> float:
	printerr("this is a virtual func")
	return new_v


## 更改某一属性基础值之前的回调
func before_base_value_change(_attribute_name: StringName, _old_v: float, new_v: float) -> float:
	printerr("this is a virtual func")
	return new_v


## 更改某一属性基础值之后的回调
func after_base_value_change(_attribute_name: StringName, _old_v: float, _new_v: float) -> void:
	printerr("this is a virtual func")