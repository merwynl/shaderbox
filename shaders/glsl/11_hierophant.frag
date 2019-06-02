
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

float rectSDF(vec2 st, vec2 s){
    st = st*2.-1.;
    return max (abs (st.x /s.x),abs (st.y /s.y) );
}

float crossSDF(vec2 st, float s){
    vec2 size = vec2 (.25, s);
    return min (rectSDF(st, size.xy), rectSDF(st, size.yx) );
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    float rect = rectSDF(st, vec2(1));
    float cross = crossSDF(st,1.);

    // 階段パターンを作成します
    color += fill(rect, .65);
    color *= step(.25, fract(cross *4.));
    
    // ブラッククロスを埋める
    color *= step(1.,cross);
    
    // 白い十字を作成します
    color += fill(cross, .65);
    
    // インナーボックスの輪郭を作成します
    color += stroke (rect, .65, .05);
    
    // 外箱の輪郭を作成する
    color += stroke (rect, .75, .025);

    gl_FragColor = vec4(color,1.0);
}