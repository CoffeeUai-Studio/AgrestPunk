extends Node
class_name RandomizeSound

static func choose_random_sound(sample):
	randomize()
	var rand_nb = randi() % sample.size()
	
	return sample[rand_nb]