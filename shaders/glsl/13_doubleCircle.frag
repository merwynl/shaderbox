
precision mediump float;
uniform vec2 u_resolution;
uniform float u_time;  

float stroke(float x, float s, float w){
    float d = step(s, x+w*.5) - step(s, x-w*.5) ;
    return clamp (d, 0., 1.);
}

float fill(float x, float size){
    return 1.-step(size, x);
}

float circleSDF(vec2 st){
    return length(st-.5)* 2.;
}

float flip(float v, float pct){
    return mix (v,1.-v,pct);
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    vec2 offset = vec2(.2, .0);
    float left = circleSDF(st + offset);
    float right = circleSDF(st - offset);

    color += flip(stroke(left,.5, .05), fill(right, .525));


    float left2 = circleSDF(st + (offset*3.));
    float right2 = circleSDF(st - (offset *3.));
    // color += stroke (left, .5, .05);
    // color += stroke (right, .5, .05);
    // color += stroke (left2, .5, .05);
    // color += stroke (right2, .5, .05);
    
    gl_FragColor = vec4(color,1.0);
}