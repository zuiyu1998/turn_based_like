class_name SkillConstraint
extends Resource
## 技能限制器
## 
## 用于验证当前属性是否满足需求，同时使用这个限制器更新属性

## 验证当前属性是否满足需求
func can_execute(_attribute_set: AttributeSet) -> bool:
    return true


## 这个限制器更新属性
func update(_attribute_set: AttributeSet) -> void:
    return
