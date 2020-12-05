#macro GRID_SIZE 10
#macro CARRIER_SIZE 5
#macro BATTLESHIP_SIZE 4
#macro DESTORYER_SIZE 3
#macro SUBMARINE_SIZE 3
#macro PATROL_SIZE 2

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

foe_add_ship(CARRIER_SIZE);
foe_add_ship(BATTLESHIP_SIZE);
foe_add_ship(DESTORYER_SIZE);
foe_add_ship(SUBMARINE_SIZE);
foe_add_ship(PATROL_SIZE);
foe_add_ship(PATROL_SIZE);