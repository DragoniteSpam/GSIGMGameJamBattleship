if (game_state == GameStates.SETUP) {
    var base_x = 64;
    var base_y = 96;
    var base_w = 32;
    var base_h = 32;
    var off_x = -16;
    var off_y = -16;
    
    if (mouse_in_rectangle(base_x, base_y, base_w * GRID_SIZE, base_h * GRID_SIZE)) {
        if (setup_selected_ship != GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            var valid = true;
            var start_x = (window_mouse_get_x() - base_x - off_x) div base_w;
            var start_y = (window_mouse_get_y() - base_y - off_y) div base_h;
            var test_x = start_x;
            var test_y = start_y;
            for (var i = 0; i < ship_sizes[@ setup_selected_ship]; i++) {
                if (test_x < 0 || test_x >= GRID_SIZE || test_y < 0 || test_y >= GRID_SIZE) {
                    valid = false;
                    break;
                }
                if (board_player[@ test_x][@ test_y] != GridStates.EMPTY) {
                    valid = false;
                    break;
                }
                test_x += dcos(setup_selected_ship_orientation);
                test_y += -dsin(setup_selected_ship_orientation);
            }
            if (valid) {
                if (player_pos[@ setup_selected_ship]) {
                    board_remove_ship(board_player, setup_selected_ship);
                }
                var test_x = start_x;
                var test_y = start_y;
                for (var i = 0; i < ship_sizes[@ setup_selected_ship]; i++) {
                    board_player[@ test_x][@ test_y] = setup_selected_ship;
                    test_x += dcos(setup_selected_ship_orientation);
                    test_y += -dsin(setup_selected_ship_orientation);
                }
                player_pos[@ setup_selected_ship] = { x: start_x, y: start_y, rot: setup_selected_ship_orientation, type: setup_selected_ship, size: ship_sizes[@ setup_selected_ship] };
                setup_selected_ship = GridStates.EMPTY;
            }
        }
    }
    
    var base_x = 64;
    var base_y = 496;
    var base_w = 160;
    var base_h = 32;
    var off_x = -16 + 32;
    var off_y = -16;
    if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 0 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_BATTLESHIP;
        }
    } else if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 1 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_CARRIER;
        }
    } else if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 2 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_DESTROYER;
        }
    } else if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 3 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_PATROL_A;
        }
    } else if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 4 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_PATROL_B;
        }
    } else if (mouse_in_rectangle(base_x + off_x, base_y + off_y + 5 * base_h, base_w, base_h)) {
        if (setup_selected_ship == GridStates.EMPTY && mouse_check_button_pressed(mb_left)) {
            setup_selected_ship = GridStates.SHIP_SUBMARINE;
        }
    }
    
    if (mouse_wheel_up()) {
        setup_selected_ship_orientation = (((setup_selected_ship_orientation div 90) + 1) % 4) * 90;
    } else if (mouse_wheel_down()) {
        setup_selected_ship_orientation = (((setup_selected_ship_orientation div 90) + 3) % 4) * 90;
    }
    
    var ready = true;
    if (!player_pos[@ GridStates.SHIP_BATTLESHIP]) ready = false;
    if (!player_pos[@ GridStates.SHIP_CARRIER]) ready = false;
    if (!player_pos[@ GridStates.SHIP_DESTROYER]) ready = false;
    if (!player_pos[@ GridStates.SHIP_PATROL_A]) ready = false;
    if (!player_pos[@ GridStates.SHIP_PATROL_B]) ready = false;
    if (!player_pos[@ GridStates.SHIP_SUBMARINE]) ready = false;
    
    if (ready && mouse_in_rectangle(base_x, base_y + 6 * base_h, base_w, base_h) && mouse_check_button_pressed(mb_left)) {
        game_state = GameStates.PLAY_YOUR_TURN_PRE;
        game_state_status = "Take the first turn!";
    }
    
    return;
}

if (game_state == GameStates.PLAY_YOUR_TURN_PRE) {
    if (game_state_cooldown > -1) {
        game_state_cooldown -= DT;
        if (game_state_cooldown < 0) {
            game_state = GameStates.PLAY_YOUR_TURN;
            game_state_cooldown = -1;
            game_state_status = "Where will you attack?";
        }
    } else {
        game_state_cooldown = ACTION_COOLDOWN;
    }
}

if (game_state == GameStates.PLAY_YOUR_TURN) {
    var base_x = 512;
    var base_y = 96;
    var base_w = sprite_get_width(spr_cell);
    var base_h = sprite_get_height(spr_cell);
    var off_x = 16;
    var off_y = 16;
    var cx = (window_mouse_get_x() - base_x + off_x) div base_w;
    var cy = (window_mouse_get_y() - base_y + off_y) div base_h;
    
    if (game_state_cooldown > -1) {
        game_state_cooldown -= DT;
        if (game_state_cooldown < 0) {
            if (board_evaluate(board_foe)) {
                game_state = GameStates.GAMEOVER_YOU_WIN;
                //game_state_status = "You win!";
                game_state_status = "Your AI wins!";
            } else {
                game_state = GameStates.PLAY_AI_TURN_PRE;
                game_state_status = "The AI is taking their turn!";
            }
            game_state_cooldown = -1;
        }
    } else {
        var target = ai_player.Act(board_foe);
        board_foe[@ target.x][@ target.y] |= GridStates.SHOT;
        game_state_cooldown = ACTION_COOLDOWN;
        var cell_label = string(target.x + 1) + chr(ord("A") + target.y);
        var type = board_foe[@ target.x][@ target.y] & GridStates.HIT_MASK;
        if (type) {
            if (board_evaluate_ship(board_foe, foe_pos[@ type])) {
                game_state_status = "Hit and sunk at " + cell_label + "!";
            } else {
                game_state_status = "Hit at " + cell_label + "!";
            }
        } else {
            game_state_status = "Miss at " + cell_label + "!";
        }
        /*
        if (cx >= 0 && cx < GRID_SIZE && cy >= 0 && cy < GRID_SIZE) {
            if (!(board_foe[cx][cy] & GridStates.SHOT) && mouse_check_button_pressed(mb_left)) {
                board_foe[cx][cy] |= GridStates.SHOT;
                var cell_label = string(cx + 1) + chr(ord("A") + cy);
                var type = board_foe[cx][cy] & GridStates.HIT_MASK;
                if (type) {
                    if (board_evaluate_ship(board_foe, foe_pos[type])) {
                        game_state_status = "Hit and sunk at " + cell_label + "!";
                    } else {
                        game_state_status = "Hit at " + cell_label + "!";
                    }
                } else {
                    game_state_status = "Miss at " + cell_label + "!";
                }
                game_state_cooldown = ACTION_COOLDOWN;
            }
        }*/
    }
    
    return;
}

if (game_state == GameStates.PLAY_AI_TURN_PRE) {
    if (game_state_cooldown > -1) {
        game_state_cooldown -= DT;
        if (game_state_cooldown < 0) {
            game_state = GameStates.PLAY_AI_TURN;
            game_state_cooldown = -1;
        }
    } else {
        game_state_cooldown = ACTION_COOLDOWN;
    }
}

if (game_state == GameStates.PLAY_AI_TURN) {
    if (game_state_cooldown > -1) {
        game_state_cooldown -= DT;
        if (game_state_cooldown < 0) {
            if (board_evaluate(board_player)) {
                game_state = GameStates.GAMEOVER_AI_WIN;
                game_state_status = "You have lost!";
            } else {
                game_state = GameStates.PLAY_YOUR_TURN_PRE;
                game_state_status = "It's your turn!";
            }
            game_state_cooldown = -1;
        }
    } else {
        var target = ai.Act();
        board_player[@ target.x][@ target.y] |= GridStates.SHOT;
        game_state_cooldown = ACTION_COOLDOWN;
        var cell_label = string(target.x + 1) + chr(ord("A") + target.y);
        var type = board_player[@ target.x][@ target.y] & GridStates.HIT_MASK;
        if (type) {
            if (board_evaluate_ship(board_player, player_pos[@ type])) {
                game_state_status = "Hit and sunk at " + cell_label + "!";
            } else {
                game_state_status = "Hit at " + cell_label + "!";
            }
        } else {
            game_state_status = "Miss at " + cell_label + "!";
        }
    }
    
    return;
}