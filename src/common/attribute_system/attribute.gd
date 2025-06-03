class_name AttributeBase
extends Resource


## 属性的唯一标识名 (例如: "MaxHealth", "AttackPower")
@export var attribute_name: StringName = &""
## 属性的显示名称 (例如: "最大生命值", "攻击力")
@export var display_name: String = ""
## 属性的详细描述
@export_multiline var description: String = ""
## 基础属性值
@export
var base_value: float = 0.0:
    set(v):
        base_value = v
        _base_value = v
## 属性允许的最小值
@export var min_value: float = - INF
## 属性允许的最大值
@export var max_value: float = INF
## 属性值是否可以为负
@export var can_be_negative: bool = false


var _base_value: float = 0.0

# 当前属性值
var _current_value: float = 0.0


func get_base_value() -> float:
    return _base_value


func get_current_value() -> float:
    return _current_value