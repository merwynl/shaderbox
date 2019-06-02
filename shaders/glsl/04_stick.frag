
precision mediump float;
uniform vec2 u_resolution;

float stroke(float x, float s, float w){
    float d = step(s, x+w*.5) - step(s, x-w*.5) ;
    return clamp (d, 0., 1.);
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;

    float offset = 0.5; 
    float size = .05;

    // 垂直線を作成します
    color+= stroke(st.x, offset, size);

    // 水平線を作成します
    color+= stroke(st.y, offset, size);

    gl_FragColor = vec4(color,1.0);
}