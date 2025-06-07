class_name AttributeSet
extends Resource

## 初始化的属性
@export var initialized_attributes: Array[Attribute] = []
## 属性数据
var _attributes: Dictionary[String, Attribute] = {}
## 属性是否初始化
var initialized: bool = false
## 属性约束
var constraint: AttributeSetConstraint = DefaultAttributeSetConstraint.new()


func initialize() -> void:
	if initialized:
		return
	
	constraint.attributes = _attributes;

	_attributes.clear()

	for initialized_attribute in initialized_attributes:
		var attribute = initialized_attribute.duplicate(true) as Attribute
		## 设置当前值
		attribute._current_value = attribute.base_value
		_attributes[attribute.attribute_name] = attribute

	initialized = true

	## 根据依赖关系初始化属性
	constraint.initialize_attribute_dependencies()

	## 初始化属性的修改器
	for attribute: Attribute in _attributes.values():
		var old_value = attribute.get_current_value()
		var new_value = attribute.get_current_value()
		var final_value = constraint.before_current_value_change(attribute.attribute_name, old_value, new_value)
		attribute._current_value = final_value


func get_attribute_current_value(attribute_name: String) -> float:
	var attr = get_attribute(attribute_name)

	if not attr:
		return 0.0
	else:
		return attr.get_current_value()


func get_attribute_base_value(attribute_name: String) -> float:
	var attr = get_attribute(attribute_name)

	if not attr:
		return 0.0
	else:
		return attr.get_base_value()


func _remove_modifier(attribute_name: String, modifier: AttributeModifier):
	var attr = get_attribute(attribute_name)
	if not attr:
		return

	var old_current_value = attr.get_current_value()
	attr._remove_modifier(modifier)
	var new_current_value = attr.get_current_value()
	constraint.after_current_value_change(attr.attribute_name, old_current_value, new_current_value)


func _add_modifier(attribute_name: String, modifier: AttributeModifier):
	var attr = get_attribute(attribute_name)
	if not attr:
		return

	var old_current_value = attr.get_current_value()
	attr._add_modifier(modifier)
	var new_current_value = attr.get_current_value()
	constraint.after_current_value_change(attr.attribute_name, old_current_value, new_current_value)


func set_current_value(attribute_name: String, current_value: float):
	var attr = get_attribute(attribute_name)
	if not attr:
		return
	
	var old_current_value = attr.get_current_value()

	var final_value = constraint.before_current_value_change(attr.attribute_name, old_current_value, current_value)
	attr._current_value = final_value

	var new_current_value = attr.get_current_value()
	constraint.after_current_value_change(attr.attribute_name, old_current_value, new_current_value)
	

func set_base_value(attribute_name: String, base_value: float):
	var attr = get_attribute(attribute_name)
	if not attr:
		return

	var old_base_value = attr.get_base_value()
	var old_current_value = attr.get_current_value()
	if old_base_value == base_value:
		return

	## 设置当前值的回调
	var final_value = constraint.before_base_value_change(attr.attribute_name, old_base_value, base_value)
	attr._set_base_value(final_value)

	var new_current_value = attr.get_current_value()

	var new_base_value = attr.get_base_value()

	constraint.after_base_value_change(attr.attribute_name, old_base_value, new_base_value)

	if old_current_value != new_current_value:
		set_current_value(attr.attribute_name, new_current_value)


## 获取属性名称对应的属性
func get_attribute(attribute_name: String) -> Attribute:
	return _attributes.get(attribute_name)
