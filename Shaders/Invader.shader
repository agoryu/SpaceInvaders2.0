shader_type canvas_item;

varying vec2 world_pos;

void vertex() {
	world_pos = (WORLD_MATRIX * vec4(VERTEX, 1.0, 1.0)).xy;
}

void fragment() {
	vec4 actualTexture = texture(TEXTURE, UV);
	
	if(world_pos.y < 300.0) {
		COLOR = vec4(21.0/255.0, 195.0/255.0, 70.0/255.0, actualTexture.a);
	} else if(world_pos.y > 300.0 && world_pos.y < 540.0) {
		COLOR = vec4(21.0/255.0, 144.0/255.0, 195.0/255.0, actualTexture.a);
	} else {
		COLOR = vec4(235.0/255.0, 46.0/255.0, 68.0/255.0, actualTexture.a);
	}
}

