randomize();

#macro GRID_SIZE 10
#macro CARRIER_SIZE 5
#macro BATTLESHIP_SIZE 4
#macro DESTORYER_SIZE 3
#macro SUBMARINE_SIZE 3
#macro PATROL_SIZE 2

#macro DEBUG true
#macro DT (delta_time / 1000000)
#macro ACTION_COOLDOWN 2

// grid states will be a mask composed of the "shot" state and
// ship type; 0x11, for example, will denote "shot patrol boat"
enum GridStates {
    EMPTY           = 0x00,
    SHOT            = 0x01,
    SHIP_BATTLESHIP = 0x02,
    SHIP_CARRIER    = 0x04,
    SHIP_DESTROYER  = 0x08,
    SHIP_PATROL_A   = 0x10,
    SHIP_PATROL_B   = 0x20,
    SHIP_SUBMARINE  = 0x40,
    HIT_MASK        = 0xfe,
    _SIZE
}

ship_sprites = array_create(GridStates._SIZE, undefined);
ship_sprites[GridStates.SHIP_BATTLESHIP] = spr_ship_battleship;
ship_sprites[GridStates.SHIP_CARRIER] = spr_ship_carrier;
ship_sprites[GridStates.SHIP_DESTROYER] = spr_ship_destroyer;
ship_sprites[GridStates.SHIP_PATROL_A] = spr_ship_patrol;
ship_sprites[GridStates.SHIP_PATROL_B] = spr_ship_patrol;
ship_sprites[GridStates.SHIP_SUBMARINE] = spr_ship_submarine;

ship_sizes = array_create(GridStates._SIZE, 0);
ship_sizes[GridStates.SHIP_BATTLESHIP] = BATTLESHIP_SIZE;
ship_sizes[GridStates.SHIP_CARRIER] = CARRIER_SIZE;
ship_sizes[GridStates.SHIP_DESTROYER] = DESTORYER_SIZE;
ship_sizes[GridStates.SHIP_PATROL_A] = PATROL_SIZE;
ship_sizes[GridStates.SHIP_PATROL_B] = PATROL_SIZE;
ship_sizes[GridStates.SHIP_SUBMARINE] = SUBMARINE_SIZE;

enum GameStates {
    SETUP,
    PLAY_YOUR_TURN,
    PLAY_YOUR_TURN_PRE,
    PLAY_AI_TURN,
    PLAY_AI_TURN_PRE,
    GAMEOVER_YOU_WIN,
    GAMEOVER_AI_WIN,
}

game_state = GameStates.SETUP;
game_state_cooldown = -1;
game_state_status = "Place your battleships!";
setup_selected_ship = GridStates.EMPTY;
setup_selected_ship_orientation = 0;

board_player = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_player[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}

board_foe = array_create(GRID_SIZE);
for (var i = 0; i < GRID_SIZE; i++) {
    board_foe[i] = array_create(GRID_SIZE, GridStates.EMPTY);
}

player_pos = array_create(GridStates._SIZE, undefined);
foe_pos = array_create(GridStates._SIZE, undefined);

foe_pos[GridStates.SHIP_CARRIER] = foe_add_ship(CARRIER_SIZE, GridStates.SHIP_CARRIER);
foe_pos[GridStates.SHIP_BATTLESHIP] = foe_add_ship(BATTLESHIP_SIZE, GridStates.SHIP_BATTLESHIP);
foe_pos[GridStates.SHIP_DESTROYER] = foe_add_ship(DESTORYER_SIZE, GridStates.SHIP_DESTROYER);
foe_pos[GridStates.SHIP_SUBMARINE] = foe_add_ship(SUBMARINE_SIZE, GridStates.SHIP_SUBMARINE);
foe_pos[GridStates.SHIP_PATROL_A] = foe_add_ship(PATROL_SIZE, GridStates.SHIP_PATROL_A);
foe_pos[GridStates.SHIP_PATROL_B] = foe_add_ship(PATROL_SIZE, GridStates.SHIP_PATROL_B);

ai = new ShipAIBasic();