
precision mediump float;
uniform vec2 u_resolution;
uniform float u_time;  

float stroke(float x, float s, float w){
    float d = step(s, x+w*.5) - step(s, x-w*.5) ;
    return clamp (d, 0., 1.);
}

float circleSDF(vec2 st){
    return length(st-.5)* 2.;
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.4784, 0.651, 0.6941);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    float size = .1;
    float width = 1.0;

    color += stroke(circleSDF(st), size, width);

    gl_FragColor = vec4(color,1.0);
}