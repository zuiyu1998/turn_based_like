class_name BattleSystem extends Node

var skill_system: SkillSystem

func _ready() -> void:
    skill_system.register_effect_processor(DamageEffectProcessor.new())