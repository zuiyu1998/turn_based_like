class_name AttributeModifier
extends Resource

## 属性修改器的类型
enum ModifierOperation {
	## 更改一个固定值
	ABSOLUTE,
	## 直接覆盖值
	OVERRIDE,
	## 基于属性的基础值计算百分比
	PERCENTAGE
}

## 属性更改器的值
var value: float = 0.0
## 属性修改器的类型
var operation: ModifierOperation = ModifierOperation.ABSOLUTE
## 修改器的来源标识
var source_uid: StringName = &""


func _init(p_value: float, p_operation: ModifierOperation, p_source_uid: StringName) -> void:
	value = p_value
	operation = p_operation
	source_uid = p_source_uid


func apply(attribute: Attribute):
	match operation:
		ModifierOperation.ABSOLUTE:
			attribute._current_value += value
		ModifierOperation.OVERRIDE:
			attribute._current_value = value
		ModifierOperation.PERCENTAGE:
			attribute._current_value += attribute.get_base_value() * value
