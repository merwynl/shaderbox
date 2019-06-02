
precision mediump float;
uniform vec2 u_resolution;
uniform float u_time;  

float circleSDF(vec2 st){
    return length(st-.5)* 2.;
}

float fill(float x, float size){
    return 1.-step(size, x);
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec2 offset = vec2(.1, .05);
    
    // float size = .1;
    // float width = 1.0;

    color += fill(circleSDF(st),.65);
    color -= fill(circleSDF(st-offset),.5);

    gl_FragColor = vec4(color,1.0);
}