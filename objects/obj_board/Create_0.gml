#macro GRID_SIZE 10

enum GridStates {
    EMPTY           = 0x00,
    SHIP            = 0x01,
    SHOT            = 0x02,
}

board_player = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_player[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}

board_foe = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_foe[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}