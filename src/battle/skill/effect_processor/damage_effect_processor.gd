class_name DamageEffectProcessor extends EffectProcessor
## 伤害效果应用器
## 
## 处理释放者造成的伤害

func _init() -> void:
    effct_type = "Damage"


func process_effect(_effect: SkillEffectData, _source: SkillComponent, _target: SkillComponent, ) -> Dictionary:
    return {}