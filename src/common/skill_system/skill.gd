class_name Skill
extends Resource
## 技能
## 
## 这是技能的抽象。

## 判断技能选择目标的类型
enum TargetType {
    ## 只能给自己使用
    SELF,
    ## 单人，可以给盟友使用，但是不包含自己
    ALLY_SINGLE,
    ## 单人，可以给盟友使用，包含自己
    ALLY_SINGLE_INCLUDE_SELF,
    ## 多人，可以给盟友使用，包含自己
    ALLY_MANY_INCLUDE_SELF,
    ## 所有，可以给盟友使用，但是不包含自己
    ALLY_ALL,
    ## 所有，可以给盟友使用，包含自己
    ALLY_ALL_INCLUDE_SELF,
    ## 敌方单体
    ENEMY_SINGLE,
    ## 敌方全体          
	ENEMY_ALL,
    ## 多个敌方
    ENEMY_MANY,
}

@export_group("target")
## 可选中的类型
@export var target_type: TargetType = TargetType.SELF
## 可选中的数量
@export var target_count: int = 0
## 技能限制器
@export var constraint_set: SkillConstraintSet = SkillConstraintSet.new()
## 技能效果数据
@export var effct_datas: Array[SkillEffectData] = []


## 是否可以执行
func can_execute(attribute_set: AttributeSet) -> bool:
    return constraint_set.can_execute(attribute_set)


## 更新属性
func update_attribute_set(attribute_set: AttributeSet) -> void:
    constraint_set.update(attribute_set)
