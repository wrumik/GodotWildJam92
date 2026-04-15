extends BreakableBody

@onready var bush_sprite: Sprite2D = $BushSprite
@onready var leaves_particles_1: CPUParticles2D = $LeavesParticles1
@onready var leaves_particles_2: CPUParticles2D = $LeavesParticles2
@onready var bush_collider: CollisionShape2D = $BushCollider

func destroy(_attack_direction: Vector2):
	SoundManager.play_sfx(Sounds.BUSH_SLICED)
	bush_sprite.visible = false
	bush_collider.disabled = true
	leaves_particles_1.emitting = true
	leaves_particles_2.emitting = true
	await leaves_particles_1.finished
	queue_free()
