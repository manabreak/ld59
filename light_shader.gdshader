shader_type canvas_item;

uniform sampler2D base_tex : source_color;
uniform sampler2D lights_tex : source_color;
uniform float light_intensity = 1.0;
uniform float base_min_light = 0.2;

void fragment() {
    vec4 base = texture(base_tex, UV);
    vec4 lights = texture(lights_tex, UV);

    // Only use RGB for light contribution
    vec3 light_contrib = lights.rgb * light_intensity;

    // Additive blend
    vec3 final_rgb =base.rgb * max(vec3(base_min_light), light_contrib);

    COLOR = vec4(final_rgb, base.a);
}