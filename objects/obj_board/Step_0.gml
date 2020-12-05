if (game_state == GameStates.SETUP) {
    var base_x = 64;
    var base_y = 496;
    var base_w = 160;
    var base_h = 32;
    if (mouse_in_rectangle(base_x, base_y + 0 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_BATTLESHIP;
        }
    }
    if (mouse_in_rectangle(base_x, base_y + 1 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_CARRIER;
        }
    }
    if (mouse_in_rectangle(base_x, base_y + 2 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_DESTROYER;
        }
    }
    if (mouse_in_rectangle(base_x, base_y + 3 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_PATROL;
        }
    }
    if (mouse_in_rectangle(base_x, base_y + 4 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_PATROL;
        }
    }
    if (mouse_in_rectangle(base_x, base_y + 5 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_SUBMARINE;
        }
    }
}