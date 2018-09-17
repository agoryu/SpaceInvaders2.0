shader_type canvas_item;

void fragment() {
	vec4 actualTexture = texture(TEXTURE, UV);
	
	if(POINT_COORD.y < 100.0) {
		COLOR = vec4(0, 200, 0, actualTexture.a);
	} else if(POINT_COORD.y > 100.0 && POINT_COORD.y < 200.0) {
		COLOR = vec4(22, 235, 212, actualTexture.a);
	}
}

