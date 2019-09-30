shader_type canvas_item;
render_mode unshaded;

uniform sampler2D gradient : hint_black;
uniform vec4 colorInicial = vec4(1.0,0.0,0.0,1.0);
uniform vec4 colorFinal = vec4(0.0,1.0,0.0,1.0);



vec4 lerpColor (vec2 st, float alpha) {
	vec4 teste = smoothstep( alpha-0.01, alpha, st) - smoothstep( alpha, alpha+0.01, st);
	  return  teste;
	//return mix( colorInicial, colorFinal, vec4 (alpha, alpha, alpha, alpha));
}

void fragment () {
	vec2 st = FRAGCOORD.y/SCREEN_PIXEL_SIZE.y;
	float step1 = SCREEN_PIXEL_SIZE.y * 0.20;
	float step2 = SCREEN_PIXEL_SIZE.y * 0.50;
	float step3 = SCREEN_PIXEL_SIZE.y * 0.75;
	
	
	
	COLOR = mix(colorInicial, colorFinal, lerpColor(st, alpha, r));
	COLOR = mix(colorInicial, colorFinal, lerpColor(st, alpha, g));
	COLOR = mix(colorInicial, colorFinal, lerpColor(st, alpha, b));
	
	//vec3 colorGradient = texture(gradient, vec2(gr
	//COLOR = lerpColor(.9);
}
 
//https://thebookofshaders.com/06/