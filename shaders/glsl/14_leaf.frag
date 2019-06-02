
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

float vesicaSDF(vec2 st, float w){
    vec2 offset = vec2(w*.5,0.);
    return max (circleSDF(st - offset), circleSDF(st+offset));
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    float sdf = vesicaSDF(st,.2);
    // color += flip(fill(sdf, .5), step((st.x+st.y)*.5, .5));
    color += flip(fill(sdf, .5), step((st.x-st.y)*.5, .5));

    gl_FragColor = vec4(1.0-color,1.0);
}