extends CSGBox

var muzzle
var gunRange = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	muzzle = GetActiveMuzzle($muzzle_mount)
	if muzzle.visible == true:
		gunRange += get_node(muzzle).get(gunRange)

# Returns the active muzzle atachment.
func GetActiveMuzzle(node):
	for n in node.get_children():
		if n.visible == true:
			muzzle = $muzzle_mount/ + n
			return muzzle
