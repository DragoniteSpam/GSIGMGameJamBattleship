var base_x = 64;
var base_y = 96;
var base_w = sprite_get_width(spr_cell);
var base_h = sprite_get_height(spr_cell);

for (var i = 0; i < GRID_SIZE; i++) {
    for (var j = 0; j < GRID_SIZE; j++) {
        draw_sprite(spr_cell, 0, base_x + i * base_w, base_y + j * base_h);
    }
}
draw_text(base_x, base_y + j * base_h, "You");

var base_x = 512;
var base_y = 96;
for (var i = 0; i < GRID_SIZE; i++) {
    for (var j = 0; j < GRID_SIZE; j++) {
        draw_sprite(spr_cell, board_foe[i][j] != GridStates.EMPTY, base_x + i * base_w, base_y + j * base_h);
    }
}
draw_text(base_x, base_y + j * base_h, "Foe");
if (keyboard_check(vk_space)) {
    draw_sprite_ext(spr_ship_battleship, 0, base_x + foe_pos_battleship.x * base_w, base_y + foe_pos_battleship.y * base_h, 1, 1, foe_pos_battleship.rot, c_white, 1);
    draw_sprite_ext(spr_ship_carrier, 0, base_x + foe_pos_carrier.x * base_w, base_y + foe_pos_carrier.y * base_h, 1, 1, foe_pos_carrier.rot, c_white, 1);
    draw_sprite_ext(spr_ship_destroyer, 0, base_x + foe_pos_destroyer.x * base_w, base_y + foe_pos_destroyer.y * base_h, 1, 1, foe_pos_destroyer.rot, c_white, 1);
    draw_sprite_ext(spr_ship_patrol, 0, base_x + foe_pos_patrol_b.x * base_w, base_y + foe_pos_patrol_b.y * base_h, 1, 1, foe_pos_patrol_b.rot, c_white, 1);
    draw_sprite_ext(spr_ship_patrol, 0, base_x + foe_pos_patrol_a.x * base_w, base_y + foe_pos_patrol_a.y * base_h, 1, 1, foe_pos_patrol_a.rot, c_white, 1);
    draw_sprite_ext(spr_ship_submarine, 0, base_x + foe_pos_submarine.x * base_w, base_y + foe_pos_submarine.y * base_h, 1, 1, foe_pos_submarine.rot, c_white, 1);
}