extends Gun
class_name Shotgun

var bullet_count = 4
var spread_min_deg = 5
var spread_max_deg = 15

func shoot():
	super.shoot()
	if not multiplayer.is_server():
		return
		
	for i in range(bullet_count):
		var sign = -1 if randf() < 0.5 else 1
		var angle_offset = deg_to_rad(randf_range(spread_min_deg, spread_max_deg)) * sign
		var dir_angle = (player.looking_at - shoot_pos.global_position).normalized().angle() + angle_offset
		
		var new_bullet: Bullet = make_bullet(player, bullet_type, dir_angle)
		get_tree().get_current_scene().get_node("Bullets").add_child(new_bullet, true)
