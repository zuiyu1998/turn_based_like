class_name SkillConstraintSet
extends Resource
## 技能限制器集合
## 
## 用于验证当前属性是否满足需求，同时使用这个限制器更新属性

## 约束器
@export
var constraints: Array[SkillConstraint] = []


## 验证当前属性是否满足需求
func can_execute(attribute_set: AttributeSet) -> bool:
    if constraints.is_empty():
        return true

    return constraints.all(func(constraint: SkillConstraint): return constraint.can_execute(attribute_set))


## 这个限制器更新属性
func update(attribute_set: AttributeSet) -> void:
    for constraint in constraints:
        constraint.update(attribute_set)
