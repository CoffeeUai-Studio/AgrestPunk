extends Node
class_name RandomizeSound

static func choose_random_sound(sample):
	randomize()
	var rand_nb = randi() % sample.size()
	print (sample[rand_nb])
	
	return sample[rand_nb]