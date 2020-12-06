draw_text(32, 32, game_state_status);

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

if (player_pos[GridStates.SHIP_BATTLESHIP]) draw_sprite_ext(spr_ship_battleship, 0, base_x + player_pos[GridStates.SHIP_BATTLESHIP].x * base_w, base_y + player_pos[GridStates.SHIP_BATTLESHIP].y * base_h, 1, 1, player_pos[GridStates.SHIP_BATTLESHIP].rot, c_white, 1);
if (player_pos[GridStates.SHIP_CARRIER]) draw_sprite_ext(spr_ship_carrier, 0, base_x + player_pos[GridStates.SHIP_CARRIER].x * base_w, base_y + player_pos[GridStates.SHIP_CARRIER].y * base_h, 1, 1, player_pos[GridStates.SHIP_CARRIER].rot, c_white, 1);
if (player_pos[GridStates.SHIP_DESTROYER]) draw_sprite_ext(spr_ship_destroyer, 0, base_x + player_pos[GridStates.SHIP_DESTROYER].x * base_w, base_y + player_pos[GridStates.SHIP_DESTROYER].y * base_h, 1, 1, player_pos[GridStates.SHIP_DESTROYER].rot, c_white, 1);
if (player_pos[GridStates.SHIP_PATROL_A])draw_sprite_ext(spr_ship_patrol, 0, base_x + player_pos[GridStates.SHIP_PATROL_A].x * base_w, base_y + player_pos[GridStates.SHIP_PATROL_A].y * base_h, 1, 1, player_pos[GridStates.SHIP_PATROL_A].rot, c_white, 1);
if (player_pos[GridStates.SHIP_PATROL_B])draw_sprite_ext(spr_ship_patrol, 0, base_x + player_pos[GridStates.SHIP_PATROL_B].x * base_w, base_y + player_pos[GridStates.SHIP_PATROL_B].y * base_h, 1, 1, player_pos[GridStates.SHIP_PATROL_B].rot, c_white, 1);
if (player_pos[GridStates.SHIP_SUBMARINE])draw_sprite_ext(spr_ship_submarine, 0, base_x + player_pos[GridStates.SHIP_SUBMARINE].x * base_w, base_y + player_pos[GridStates.SHIP_SUBMARINE].y * base_h, 1, 1, player_pos[GridStates.SHIP_SUBMARINE].rot, c_white, 1);

for (var i = 0; i < GRID_SIZE; i++) {
    for (var j = 0; j < GRID_SIZE; j++) {
        if (board_player[i][j] & GridStates.SHOT) {
            var damaged = board_player[i][j] & GridStates.HIT_MASK;
            draw_sprite(spr_cell_shot, damaged, base_x + i * base_w, base_y + j * base_h);
        }
    }
}

var base_x = 512;
var base_y = 96;
for (var i = 0; i < GRID_SIZE; i++) {
    for (var j = 0; j < GRID_SIZE; j++) {
        draw_sprite(spr_cell, 0, base_x + i * base_w, base_y + j * base_h);
        if (board_foe[i][j] & GridStates.SHOT) {
            var damaged = !!(board_foe[i][j] & GridStates.HIT_MASK);
            draw_sprite(spr_cell_shot, damaged, base_x + i * base_w, base_y + j * base_h);
        }
    }
}
draw_text(base_x, base_y + j * base_h, "Foe");

if (DEBUG) {
    var base_x = 960;
    var base_y = 96;
    for (var i = 0; i < GRID_SIZE; i++) {
        for (var j = 0; j < GRID_SIZE; j++) {
            draw_sprite(spr_cell, 0, base_x + i * base_w, base_y + j * base_h);
        }
    }
    draw_text(base_x, base_y + j * base_h, "Foe (debug - hold space)");
    if (keyboard_check(vk_space)) {
        draw_sprite_ext(spr_ship_battleship, 0, base_x + foe_pos_battleship.x * base_w, base_y + foe_pos_battleship.y * base_h, 1, 1, foe_pos_battleship.rot, c_white, 1);
        draw_sprite_ext(spr_ship_carrier, 0, base_x + foe_pos_carrier.x * base_w, base_y + foe_pos_carrier.y * base_h, 1, 1, foe_pos_carrier.rot, c_white, 1);
        draw_sprite_ext(spr_ship_destroyer, 0, base_x + foe_pos_destroyer.x * base_w, base_y + foe_pos_destroyer.y * base_h, 1, 1, foe_pos_destroyer.rot, c_white, 1);
        draw_sprite_ext(spr_ship_patrol, 0, base_x + foe_pos_patrol_b.x * base_w, base_y + foe_pos_patrol_b.y * base_h, 1, 1, foe_pos_patrol_b.rot, c_white, 1);
        draw_sprite_ext(spr_ship_patrol, 0, base_x + foe_pos_patrol_a.x * base_w, base_y + foe_pos_patrol_a.y * base_h, 1, 1, foe_pos_patrol_a.rot, c_white, 1);
        draw_sprite_ext(spr_ship_submarine, 0, base_x + foe_pos_submarine.x * base_w, base_y + foe_pos_submarine.y * base_h, 1, 1, foe_pos_submarine.rot, c_white, 1);
        for (var i = 0; i < GRID_SIZE; i++) {
            for (var j = 0; j < GRID_SIZE; j++) {
                if (board_foe[i][j] & GridStates.SHOT) {
                    var damaged = board_foe[i][j] & GridStates.HIT_MASK;
                    draw_sprite(spr_cell_shot, damaged, base_x + i * base_w, base_y + j * base_h);
                }
            }
        }
    }
}

if (game_state == GameStates.SETUP) {
    var base_x = 64;
    var base_y = 496;
    var off_x = 32;
    var off_y = 0;
    draw_sprite(spr_ship_battleship, 0, base_x + off_x, base_y + off_y + 0 * base_h);
    draw_sprite(spr_ship_carrier, 0, base_x + off_x, base_y + off_y + 1 * base_h);
    draw_sprite(spr_ship_destroyer, 0, base_x + off_x, base_y + off_y + 2 * base_h);
    draw_sprite(spr_ship_patrol, 0, base_x + off_x, base_y + off_y + 3 * base_h);
    draw_sprite(spr_ship_patrol, 0, base_x + off_x, base_y + off_y + 4 * base_h);
    draw_sprite(spr_ship_submarine, 0, base_x + off_x, base_y + off_y + 5 * base_h);
    
    var ready = true;
    if (player_pos[GridStates.SHIP_BATTLESHIP]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 0 * base_h);
    else ready = false;
    if (player_pos[GridStates.SHIP_CARRIER]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 1 * base_h);
    else ready = false;
    if (player_pos[GridStates.SHIP_DESTROYER]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 2 * base_h);
    else ready = false;
    if (player_pos[GridStates.SHIP_PATROL_A]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 3 * base_h);
    else ready = false;
    if (player_pos[GridStates.SHIP_PATROL_B]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 4 * base_h);
    else ready = false;
    if (player_pos[GridStates.SHIP_SUBMARINE]) draw_sprite(spr_ui_ship_set, 0, base_x, base_y + off_y + 5 * base_h);
    else ready = false;
    
    if (setup_selected_ship != GridStates.EMPTY) {
        draw_sprite_ext(ship_sprites[setup_selected_ship], 0, window_mouse_get_x(), window_mouse_get_y(), 1, 1, setup_selected_ship_orientation, c_white, 1);
    }
    
    if (ready) {
        draw_sprite(spr_ui_ready, 0, base_x, base_y + 6 * base_h);
    } else {
        draw_text(base_x, base_y + 6 * base_h, "scroll the mouse wheel to rotate your ship");
    }
}