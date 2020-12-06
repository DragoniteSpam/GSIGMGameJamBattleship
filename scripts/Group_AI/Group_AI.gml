function ShipAIRandom(board, ships) constructor {
    self.board = board;
    self.ships = ships;
    
    Act = function() {
        while (true) {
            var cx = irandom(GRID_SIZE - 1);
            var cy = irandom(GRID_SIZE - 1);
            if (!(board[cx][cy] & GridStates.SHOT)) {
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
        self.tracking = false;
        self.owner = owner;
        
        self.Position = function(x, y) {
            self.x = x;
            self.y = y;
            self.target = self.owner.ships[self.owner.board[x][y] & GridStates.HIT_MASK];
        };
        
        self.Position(x, y);
    };
    
    Act = function() {
        if (test_hit) {
            if (test_hit.tracking) {
                var cx = test_hit.x + dcos(test_hit.seek);
                var cy = test_hit.y - dsin(test_hit.seek);
                
                if (cx >= 0 && cx < GRID_SIZE && cy >= 0 && cy < GRID_SIZE) {
                    if (!(board[cx][cy] & GridStates.SHOT)) {
                        if (board[cx][cy] & GridStates.HIT_MASK) {
                            test_hit.Position(cx, cy);
                            if (board_evaluate_ship_test(board, test_hit.target, cx, cy)) {
                                test_hit = undefined;
                            }
                            return { x: cx, y: cy };
                        }
                    }
                }
                
                test_hit.seek += 180;
                for (var i = 0; i < test_hit.target.size; i++) {
                    var cx = test_hit.x + dcos(test_hit.seek);
                    var cy = test_hit.y - dsin(test_hit.seek);
                    if (!(board[cx][cy] & GridStates.SHOT)) {
                        if (board_evaluate_ship_test(board, test_hit.target, cx, cy)) {
                            test_hit = undefined;
                        }
                        return { x: cx, y: cy };
                    }
                    test_hit.Position(cx, cy);
                }
            }
            repeat (4) {
                var cx = test_hit.x + dcos(test_hit.seek);
                var cy = test_hit.y - dsin(test_hit.seek);
                if (cx >= 0 && cx < GRID_SIZE && cy >= 0 && cy < GRID_SIZE) {
                    if (!(board[cx][cy] & GridStates.SHOT)) {
                        if (board[cx][cy] & GridStates.HIT_MASK) {
                            if (board_evaluate_ship_test(board, test_hit.target, cx, cy)) {
                                test_hit = undefined;
                            } else {
                                test_hit.Position(cx, cy);
                                test_hit.tracking = true;
                            }
                        } else {
                            test_hit.seek += 180;
                        }
                        return { x: cx, y: cy };
                    }
                }
                test_hit.seek += 90;
            }
        }
        
        while (true) {
            var cx = irandom(GRID_SIZE - 1);
            var cy = irandom(GRID_SIZE - 1);
            if (!(board[cx][cy] & GridStates.SHOT)) {
                if (board[cx][cy] & GridStates.HIT_MASK) {
                    test_hit = new testHitData(cx, cy, self);
                }
                return { x: cx, y: cy };
            }
        }
    };
}