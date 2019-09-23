shader_type canvas_item;

uniform vec4 Inicialcolor = vec4(0.0, 1.0, 0.0,1.0);
uniform vec4 Finalcolor = vec4(1.0, 0.0, 0.0,1.0);

void fragment () {
	vec4 gradientColor = step( vec4 Inicialcolor, vec4 Finalcolorm, st.y);
	COLOR = gradientColor;
	
}


