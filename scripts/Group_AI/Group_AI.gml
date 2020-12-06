function ShipAIRandom(board, ships) constructor {
    self.board = board;
    self.ships = ships;
    
    Act = function() {
        while (true) {
            var cx = irandom(GRID_SIZE - 1);
            var cy = irandom(GRID_SIZE - 1);
            if (board_valid_shot(board, cx, cy)) {
                return { x: cx, y: cy };
            }
        }
    };
}

function ShipAIBasic(board, ships) constructor {
    self.test_hit = undefined;
    self.board = board;
    self.ships = ships;
    
    self.testHitData = function(x, y, owner) constructor {
        self.seek = choose(0, 90, 180, 270);
        self.owner = owner;
        
        self.Position = function(x, y) {
            self.x = x;
            self.y = y;
            self.target = self.owner.ships[@ self.owner.board[@ x][@ y] & GridStates.HIT_MASK];
        };
        
        self.Position(x, y);
    };
    
    Act = function() {
        if (test_hit) {
            repeat (4) {
                var cx = test_hit.x + dcos(test_hit.seek);
                var cy = test_hit.y - dsin(test_hit.seek);
                if (board_valid_shot(board, cx, cy)) {
                    if (board_hit_ship(board, cx, cy)) {
                        if (board_evaluate_ship_test(board, test_hit.target, cx, cy)) {
                            test_hit = undefined;
                        } else {
                            test_hit.Position(cx, cy);
                            var tx = cx + dcos(test_hit.seek);
                            var ty = cy - dsin(test_hit.seek);
                            if (!board_hit_ship(board, tx, ty)) {
                                test_hit.seek += 180;
                                var tx = cx;
                                var ty = cy;
                                repeat (GRID_SIZE) {
                                    if (board_hit_ship(board, tx + dcos(test_hit.seek), ty - dsin(test_hit.seek))) {
                                        test_hit.Position(tx, ty);
                                        break;
                                    }
                                    tx += dcos(test_hit.seek);
                                    ty -= dsin(test_hit.seek);
                                }
                            }
                        }
                    } else {
                        test_hit.seek += 90;
                    }
                    return { x: cx, y: cy };
                }
                test_hit.seek += 90;
            }
        }
        
        // start by firing randomly
        while (true) {
            var cx = irandom(GRID_SIZE - 1);
            var cy = irandom(GRID_SIZE - 1);
            if (board_valid_shot(board, cx, cy)) {
                if (board_hit_ship(board, cx, cy)) {
                    test_hit = new testHitData(cx, cy, self);
                }
                return { x: cx, y: cy };
            }
        }
    };
}