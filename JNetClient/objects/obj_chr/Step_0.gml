if (mouse_check_button(mb_left)) {
	dx = mouse_x;
	dy = mouse_y;
}

if (point_distance(x, y, dx, dy) > 5) {
	move_towards_point(dx, dy, 5);
}
else {
	speed = 0;
}