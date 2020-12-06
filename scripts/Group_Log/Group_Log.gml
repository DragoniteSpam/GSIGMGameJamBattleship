function status(text) {
    obj_board.game_state_status = text;
    ds_list_add(obj_board.game_status_logs, text);
}