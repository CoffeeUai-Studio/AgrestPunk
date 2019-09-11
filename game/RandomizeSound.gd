extends Node
class_name RandomizeSound

static func choose_random_sound(sample):
	var rand_nb = Randi() % sample.size()
	
	return sample[rand_nb]