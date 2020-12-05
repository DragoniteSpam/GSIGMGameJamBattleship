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
        draw_sprite(spr_cell, 0, base_x + i * base_w, base_y + j * base_h);
    }
}
draw_text(base_x, base_y + j * base_h, "Foe");