extends Node

class_name Weapon

export var fire_rate = 0

export var fire_range  = 0
export var clip_size  = 0
export var reload_rate  = 0
export var damage  = 0
export var stability  = 0

onready var body = $Body
onready var barrel = $Barrel
onready var stock = $Stock
onready var magazine = $Magazine
onready var grip = $Grip
onready var scope = $Scope
onready var components = [body, barrel, stock, magazine, grip, scope]

onready var raycast = $"root/Player/RotationHelper/Head/Camera/RayCast"
var current_ammo = 0
var can_fire = true
var reloading = false

func _ready():
	current_ammo = clip_size
	raycast.cast_to = fire_range
	get_active_components()

func _process(_delta):
	# ammo_label.set_text("%d / %d" % [current_ammo, clip_size]
	
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		# fire weapon
		if current_ammo > 0 and not reloading:
			fire()
		elif not reloading:
			reload()
	if Input.is_action_just_pressed("reload") and not reloading and current_ammo < clip_size:
		reload()
			
func fire():
	print("Fired weapon")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func reload():
	print("Reloading...")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	reloading = false
	print("Reload complete")
	
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed" + collider.name)
	
func get_active_components():
	fire_rate = body.fire_rate
	for n in body.get_children():
		if n.visible == true:
			fire_range += n.fire_range
			clip_size += n.clip_size 
			reload_rate += n.reload_rate
			damage += n.damage
			stability += n.stability
