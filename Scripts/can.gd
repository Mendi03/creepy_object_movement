extends RigidBody3D

var teleportTarget = Vector3(0, 1.215, 6)
var teleportTarget2 = Vector3(6.846, 1.215, -6.406)
var teleportTarget3 = Vector3(-7.36, 1.215, -6.406)

var positions = [teleportTarget, teleportTarget2, teleportTarget3]



func _on_visible_on_screen_notifier_3d_2_screen_exited():
	global_transform.origin = positions.pick_random()
		
