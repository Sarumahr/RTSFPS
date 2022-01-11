extends Weapon

func _ready():
	Weapon.raycast.cast_to = Vector3(0, 0, -fire_range)
