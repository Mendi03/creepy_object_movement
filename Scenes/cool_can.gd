extends CharacterBody3D

const OCC_RAY_TARGET_Y_OFFSET = 0.5

var _occlusion_check_rays : Array[RayCast3D]
var is_looked_at = true

@export var target_player : CharacterBody3D

@onready var vis = $VisibleOnScreenNotifier3D
@onready var Occlusion_Check_Rays_Parent = $OcclusionCheckRaysParent

func _ready():
	for r in Occlusion_Check_Rays_Parent.get_children():
		if r is RayCast3D:
			#r.add_exception(target_player) 
			_occlusion_check_rays.append(r)
	
	
func _physics_process(_delta):
	is_looked_at = _is_viewed()
	
	if is_looked_at:
		return
		
	var teleportTarget = Vector3(0, 1, 6)
	var teleportTarget2 = Vector3(6.846, 1, -6.406)
	var teleportTarget3 = Vector3(-7.36, 1, -6.406)

	var positions = [teleportTarget, teleportTarget2, teleportTarget3]

	global_transform.origin = positions.pick_random()

#func _on_visible_on_screen_notifier_3d_2_screen_exited():
	#global_transform.origin = positions.pick_random()

func _is_viewed() -> bool:
	var viewed = vis.is_on_screen()
	
	# if statue not on screen, we can already stop
	if not viewed:
		return viewed
	
	'''
	var colliding_rays = 0
	
	# make raycasts point to player position and count how many are colliding with an obstacle
	for r in _occlusion_check_rays:
		r.target_position = (target_player.global_position - r.global_position) * self.basis
		r.target_position.y += OCC_RAY_TARGET_Y_OFFSET
		if viewed and r.is_colliding():
			colliding_rays += 1
	
	# if all raycasts are colliding, the statue is hidden by an obstacle
	if colliding_rays >= _occlusion_check_rays.size():
		viewed = false
	'''
	return viewed

