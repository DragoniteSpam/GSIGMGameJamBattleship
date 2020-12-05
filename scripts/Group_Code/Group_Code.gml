function foe_add_ship(size, flag) {
    // clone the board and try random positions until you're able
    // to add a ship unimpeded by both other ships and the confines
    // of the game board
    while (true) {
        var orientation = choose(0, 90, 180, 270);
        var clone = board_clone(board_foe);
        var pos_x = irandom(GRID_SIZE);
        var pos_y = irandom(GRID_SIZE);
        var test_x = pos_x;
        var test_y = pos_y;
        var valid = true;
        for (var i = 0; i < size; i++) {
            if (test_x < 0 || test_x >= GRID_SIZE || test_y < 0 || test_y >= GRID_SIZE) {
                valid = false;
                break;
            }
            if (clone[test_x][test_y] != GridStates.EMPTY) {
                valid = false;
                break;
            }
            clone[test_x][test_y] = flag;
            test_x += dcos(orientation);
            test_y += -dsin(orientation);
        }
        // Return a struct containing the position and rotation
        // of each ship, one valid placement has been found
        if (valid) {
            board_foe = clone;
            return { x: pos_x, y: pos_y, rot: orientation };
        }
    }
}

function board_clone(board) {
    var clone = array_create(GRID_SIZE);
    for (var i = 0; i < GRID_SIZE; i++) {
        clone[i] = array_create(GRID_SIZE, GridStates.EMPTY);
        array_copy(clone[i], 0, board[i], 0, GRID_SIZE);
    }
    return clone;
}

function mouse_in_rectangle(x, y, w, h) {
    return point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), x, y, x + w, y + h);
}