function foe_add_ship(size, flag) {
    while (true) {
        var orientation = choose([1, 0], [-1, 0], [0, 1], [0, -1]);
        var clone = board_clone(board_foe);
        var test_x = irandom(GRID_SIZE);
        var test_y = irandom(GRID_SIZE);
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
            test_x += orientation[0];
            test_y += orientation[1];
        }
        if (valid) {
            board_foe = clone;
            return;
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