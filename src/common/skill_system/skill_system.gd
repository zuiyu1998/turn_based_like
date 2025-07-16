class_name SkillSystem
extends RefCounted
## 技能系统
## 
## 用于技能的执行

## 效果处理器
var effect_processors: Dictionary[String, EffectProcessor] = {}


## 注册技能效果处理器
func register_effect_processor(processor: EffectProcessor) -> void:
	effect_processors[processor.effct_type] = processor


## 执行单个效果
func _apply_single_effect(caster: SkillComponent, target: SkillComponent, effect: SkillEffectData) -> Dictionary:
	var res = {}
	var processor = effect_processors.get(effect.effct_type) as EffectProcessor

	if not processor:
		return res

	res = processor.process_effect(effect, caster, target)

	return res


## 处理技能影响
func _process_skill_effects(caster: SkillComponent, skill: Skill, selected_targets: Array[SkillComponent]) -> Dictionary:
	var results = {}
	
	for target in selected_targets:
		results[target] = {}

		for effct in skill.effct_datas:
			var effect_result = _apply_single_effect(caster, target, effct)

			for key in effect_result:
				results[target][key] = effect_result[key]
	return results


## 更改属性
func _consume_attribute_set(caster: SkillComponent, skill: Skill) -> void:
	skill.consume_attribute_set(caster.attribute_set)


## 验证技能是否可以释放
func verify_skill_can_execute(caster: SkillComponent, skill: Skill) -> bool:
	## 验证释放者的属性
	if not skill.can_execute(caster.attribute_set):
		return false

	return true


## 执行技能
func execute_skill(caster: SkillComponent, skill: Skill, selected_targets: Array[SkillComponent]) -> bool:
	_consume_attribute_set(caster, skill)

	_process_skill_effects(caster, skill, selected_targets)

	return true
