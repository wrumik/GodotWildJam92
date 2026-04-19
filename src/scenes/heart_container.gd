class_name HeartContainer
extends TextureRect

enum HeartState {
	EMPTY,
	HALF,
	FULL
}

var state: HeartState = HeartState.EMPTY:
	set(value):
		state = value
		var frame: int = 0
		match state:
			HeartState.EMPTY:
				frame = 2
			HeartState.HALF:
				frame = 1
			HeartState.FULL:
				frame = 0
		
		texture.region.position.x = frame * 16
