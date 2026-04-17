class_name Animator
extends AnimationPlayer

var last_dir_name: String = ""

func _ready() -> void:
	animation_finished.connect(
	func(anim: String): 
		if "attack" in anim:
			play("RESET")
		)

func update(_motion: Vector2, looking: Vector2, _delta: float) -> void:
	var dir = GridMover.dir_to_cardinal(looking)
	
	match dir:
		Vector2i.LEFT:
			last_dir_name = "left"
		Vector2i.RIGHT:
			last_dir_name = "right"
		Vector2i.UP:
			last_dir_name = "up"
		Vector2i.DOWN:
			last_dir_name = "down"
		_: 
			last_dir_name = "down"
	
	if not "attack" in current_animation:
		play("move_" + last_dir_name)


func play_attack() -> void:
	play("attack_" + last_dir_name)
