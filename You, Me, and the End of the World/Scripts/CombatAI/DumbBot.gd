extends "res://Scripts/CombatAI/CombatEnemy.gd"

func _physics_process(delta):
    staminaRegen()
    updateGravity()
