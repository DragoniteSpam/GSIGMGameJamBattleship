function ShipAI() constructor {
    Act = function() {
        while (true) {
            var cx = irandom(GRID_SIZE - 1);
            var cy = irandom(GRID_SIZE - 1);
            if (!(obj_board.board_player[cx][cy] & GridStates.SHOT)) {
                return { x: cx, y: cy };
            }
        }
    };
}