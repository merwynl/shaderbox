
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

float flip(float v, float pct){
    return mix (v,1.-v,pct);
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.3843, 0.2, 0.8118);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    // 長方形のサイズを設定します
    float widthx = .25;
    float widthy = .5;

    // パターンを作成します
    float rect = rectSDF(st, vec2(widthx,widthy));
    float diag = (st.x+st.y)*.5;

    // パターンのいろを塗りぶす
    color += flip(fill(rect,.9), stroke(diag,.5,.01));

    gl_FragColor = vec4(color,1.0);
}