class_name Mouth
extends AnimatedSprite2D

func start_tell(tell: Tell):
	pass

func stop_tell(tell: Tell):
	pass

func enounciate(letter: String):
	assert (letter.length() == 1)
	
	match(letter):
		"a":
			frame = 0
		"e":
			frame = 1
		"f", "v", "w":
			frame = 2
		"i":
			frame = 3
		"o", "u":
			frame = 4
		"y":
			frame = 5
		"b", "p", "m":
			frame = 6
		_:
			pass
	
