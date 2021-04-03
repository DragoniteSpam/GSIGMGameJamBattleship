global._part_system = part_system_create();

part_system_automatic_update(global._part_system, true);
part_system_automatic_draw(global._part_system, true);
var _fps = game_get_speed(gamespeed_fps);

/* Sparks */
global._part_type_0 = part_type_create();
part_type_speed(global._part_type_0, 6, 8, -0.03, 0);
part_type_direction(global._part_type_0, 0, 180, 0, 0);
part_type_gravity(global._part_type_0, 0.01, 270);
part_type_orientation(global._part_type_0, 0, 0, 0, 0, 0);
part_type_size(global._part_type_0, 0.25, 0.25, 0, 0);
part_type_scale(global._part_type_0, 1, 1);
part_type_life(global._part_type_0, 0.60 * _fps, 1 * _fps);
part_type_blend(global._part_type_0, true);
part_type_color3(global._part_type_0, 49151, 65535, 32767);
part_type_alpha3(global._part_type_0, 1, 1, 0);
part_type_shape(global._part_type_0, pt_shape_sphere);
/* Smoke */
global._part_type_1 = part_type_create();
part_type_speed(global._part_type_1, 2, 3, 0, 0);
part_type_direction(global._part_type_1, 0, 360, 0, 0);
part_type_gravity(global._part_type_1, 0.05, 90);
part_type_orientation(global._part_type_1, 0, 360, 0, 0, 0);
part_type_size(global._part_type_1, 1, 1, -0.00, 0);
part_type_scale(global._part_type_1, 0.50, 0.50);
part_type_life(global._part_type_1, 2 * _fps, 2 * _fps);
part_type_blend(global._part_type_1, false);
part_type_color3(global._part_type_1, 16777215, 4144959, 16777215);
part_type_alpha3(global._part_type_1, 0, 0.02, 0);
part_type_shape(global._part_type_1, pt_shape_disk);
/* Secondary Oxidation */
global._part_type_2 = part_type_create();
part_type_speed(global._part_type_2, 0, 0, 0, 0);
part_type_direction(global._part_type_2, 0, 0, 0, 0);
part_type_gravity(global._part_type_2, 0, 270);
part_type_orientation(global._part_type_2, 0, 0, 0, 0, 0);
part_type_size(global._part_type_2, 1, 1, -0.05, 0);
part_type_scale(global._part_type_2, 0.75, 0.75);
part_type_life(global._part_type_2, 0.50 * _fps, 0.50 * _fps);
part_type_blend(global._part_type_2, true);
part_type_color3(global._part_type_2, 16383, 255, 16383);
part_type_alpha3(global._part_type_2, 1, 1, 0);
part_type_shape(global._part_type_2, pt_shape_sphere);
/* Oxidation Reaction */
global._part_type_3 = part_type_create();
part_type_speed(global._part_type_3, 8, 8, 0, 0);
part_type_direction(global._part_type_3, 0, 180, 0, 0);
part_type_gravity(global._part_type_3, 0.25, 270);
part_type_orientation(global._part_type_3, 0, 0, 0, 0, 0);
part_type_size(global._part_type_3, 1, 1, -0.10, 0);
part_type_scale(global._part_type_3, 1, 1);
part_type_life(global._part_type_3, 0.75 * _fps, 1 * _fps);
part_type_blend(global._part_type_3, true);
part_type_color3(global._part_type_3, 24575, 24575, 49151);
part_type_alpha3(global._part_type_3, 1, 1, 0);
part_type_shape(global._part_type_3, pt_shape_sphere);
/* Secondary Sparks */
global._part_type_4 = part_type_create();
part_type_speed(global._part_type_4, 0, 0, 0, 0);
part_type_direction(global._part_type_4, 0, 0, 0, 0);
part_type_gravity(global._part_type_4, 0.05, 270);
part_type_orientation(global._part_type_4, 0, 0, 0, 0, 0);
part_type_size(global._part_type_4, 0.10, 0.10, 0, 0);
part_type_scale(global._part_type_4, 1, 1);
part_type_life(global._part_type_4, 0.50 * _fps, 0.50 * _fps);
part_type_blend(global._part_type_4, false);
part_type_color2(global._part_type_4, 65535, 255);
part_type_alpha2(global._part_type_4, 1, 0);
part_type_shape(global._part_type_4, pt_shape_sphere);

part_type_step(global._part_type_0, ceil(-30/ _fps), global._part_type_4);
part_type_step(global._part_type_3, ceil(60/ _fps), global._part_type_2);

/* Explosion Source */
global._part_emitter_0 = part_emitter_create(global._part_system);
part_emitter_region(global._part_system, global._part_emitter_0, 384, 416, 448, 480, ps_shape_ellipse, ps_distr_gaussian);
var _odds = 60;
if (_odds < _fps) {
    var _rate =  -1 / (_odds / _fps);
} else {
    var _rate = _odds / _fps;
}
// part_emitter_stream(global._part_system, global._part_emitter_0, global._part_type_3, _rate);
/* Sparks Source */
global._part_emitter_1 = part_emitter_create(global._part_system);
part_emitter_region(global._part_system, global._part_emitter_1, 384, 416, 416, 448, ps_shape_ellipse, ps_distr_gaussian);
var _odds = 120;
if (_odds < _fps) {
    var _rate =  -1 / (_odds / _fps);
} else {
    var _rate = _odds / _fps;
}
// part_emitter_stream(global._part_system, global._part_emitter_1, global._part_type_0, _rate);

function particle_explode() {
    part_emitter_burst(global._part_system, global._part_emitter_1, global._part_type_2, 10);
    part_emitter_burst(global._part_system, global._part_emitter_1, global._part_type_1, 10);
}