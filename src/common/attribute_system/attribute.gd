class_name Attribute
extends Resource


## 属性的唯一标识名 (例如: "MaxHealth", "AttackPower")
@export var attribute_name: StringName = &""
## 属性的显示名称 (例如: "最大生命值", "攻击力")
@export var display_name: String = ""
## 属性的详细描述
@export_multiline var description: String = ""
## 基础属性值
@export
var base_value: float = 0.0
## 属性允许的最小值
@export var min_value: float = - INF
## 属性允许的最大值
@export var max_value: float = INF
## 属性值是否可以为负
@export var can_be_negative: bool = false


# 当前属性值
var current_value: float = 0.0

# 修改器列表
var _modifier_list: Array[AttributeModifier] = []


func set_base_value(v: float):
	base_value = v
	_recalculate_current_value()


func add_modifier(modifier: AttributeModifier):
	if not modifier in _modifier_list:
		_modifier_list.append(modifier)
		_recalculate_current_value()


func remove_modifier(modifier: AttributeModifier):
	if modifier in _modifier_list:
		_modifier_list.erase(modifier)
		_recalculate_current_value()


func _recalculate_current_value():
	var modifier_list := _modifier_list.duplicate()
	
	var absolute_modifier_list = []
	var override_modifier
	var percentage_modifier_list = []

	for modifier: AttributeModifier in modifier_list:
		match modifier.operation:
			AttributeModifier.ModifierOperation.ABSOLUTE:
				absolute_modifier_list.push_back(modifier)
			AttributeModifier.ModifierOperation.OVERRIDE:
				override_modifier = modifier
			AttributeModifier.ModifierOperation.PERCENTAGE:
				percentage_modifier_list.push_back(modifier)

	for modifier: AttributeModifier in absolute_modifier_list:
		modifier.apply(self)

	for modifier: AttributeModifier in percentage_modifier_list:
		modifier.apply(self)

	if not override_modifier:
		override_modifier.apply(self)

	var final_value = current_value

	if not can_be_negative and final_value < 0.0:
		final_value = 0.0
	
	final_value = clampf(final_value, min_value, max_value)
	current_value = final_value


func get_base_value() -> float:
	return base_value


func get_current_value() -> float:
	return current_value
