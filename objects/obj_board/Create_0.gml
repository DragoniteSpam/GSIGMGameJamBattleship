randomize();

#macro GRID_SIZE 10
#macro CARRIER_SIZE 5
#macro BATTLESHIP_SIZE 4
#macro DESTORYER_SIZE 3
#macro SUBMARINE_SIZE 3
#macro PATROL_SIZE 2

// grid states will be a mask composed of the "shot" state and
// ship type; 0x11, for example, will denote "shot patrol boat"
enum GridStates {
    EMPTY           = 0x00,
    SHOT            = 0x01,
    SHIP_BATTLESHIP = 0x02,
    SHIP_CARRIER    = 0x04,
    SHIP_DESTROYER  = 0x08,
    SHIP_PATROL     = 0x10,
    SHIP_SUBMARINE  = 0x20,
}

enum GameStates {
    SETUP,
    PLAY,
}

game_state = GameStates.SETUP;

board_player = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_player[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}

board_foe = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_foe[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}

foe_pos_carrier = foe_add_ship(CARRIER_SIZE, GridStates.SHIP_CARRIER);
foe_pos_battleship = foe_add_ship(BATTLESHIP_SIZE, GridStates.SHIP_BATTLESHIP);
foe_pos_destroyer = foe_add_ship(DESTORYER_SIZE, GridStates.SHIP_DESTROYER);
foe_pos_submarine = foe_add_ship(SUBMARINE_SIZE, GridStates.SHIP_SUBMARINE);
foe_pos_patrol_a = foe_add_ship(PATROL_SIZE, GridStates.SHIP_PATROL);
foe_pos_patrol_b = foe_add_ship(PATROL_SIZE, GridStates.SHIP_PATROL);