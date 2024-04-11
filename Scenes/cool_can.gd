extends CharacterBody3D

const OCC_RAY_TARGET_Y_OFFSET = 0.5

var _occlusion_check_rays : Array[RayCast3D]
var is_looked_at = true
var can_moved = false
var has_collided = false
var previous_position : Vector3
var ready_to_move = false

@onready var target_player = $"../Player"

@onready var vis = $VisibleOnScreenNotifier3D
@onready var Occlusion_Check_Rays_Parent = $OcclusionCheckRaysParent

func _ready():
	
	if not target_player:
		printerr(self.name + " has no player target")
		set_physics_process(false)
		return
		
	for r in Occlusion_Check_Rays_Parent.get_children():
		if r is RayCast3D:
			r.add_exception(self) 
			r.add_exception(target_player) 
			_occlusion_check_rays.append(r)
	
	#previous_position = global_position
	
	
func _physics_process(_delta):
	var on_screen = vis.is_on_screen()
	var behind_obstacle = _ray_colliding()
	
	if on_screen and behind_obstacle:
		_move_can()
	elif not on_screen and behind_obstacle:
		return
	elif not behind_obstacle and on_screen:
		return
	elif (not on_screen) and (not behind_obstacle):
		_move_can()

func _ray_colliding() -> bool:
	var colliding_rays = 0
	var behind_obst : bool
	
	# make raycasts point to player position and count how many are colliding with an obstacle
	for r in _occlusion_check_rays:
		r.target_position = (target_player.global_position - r.global_position) * self.basis
		r.target_position.y += OCC_RAY_TARGET_Y_OFFSET
		if r.is_colliding():
			colliding_rays += 1
	# if all raycasts are colliding, the can is hidden by an obstacle
	if colliding_rays >= _occlusion_check_rays.size():
		behind_obst = true
		return behind_obst
	
	behind_obst = false
	return behind_obst
	
	
func _move_can():
	var coord = Vector3(0, 1, 6)
	var coord2 = Vector3(6.846, 1, -6.406)
	var coord3 = Vector3(-7.36, 1, -6.406)
	var positions = [coord, coord2, coord3]

	global_position = positions.pick_random()
	return

