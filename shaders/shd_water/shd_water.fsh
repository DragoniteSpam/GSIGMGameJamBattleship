varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D displacementMap;
uniform float time;

void main() {
    vec2 time_offset = vec2(time, -time / 2.) / 4.;
    vec4 displace = texture2D(displacementMap, v_vTexcoord + time_offset);
    float brightness = displace.r - 0.5;
    vec2 offset = vec2(brightness, 0.) / 4.;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + offset);
}