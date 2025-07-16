class_name EffectProcessor
extends RefCounted
## 技能效果应用器
## 
## 处理技能释放者和目标之间的交互

var effct_type: String

## 处理技能释放者和目标之间的交互
func process_effect(_effect: SkillEffectData, _source: SkillComponent, _target: SkillComponent, ) -> Dictionary:
    return {}
