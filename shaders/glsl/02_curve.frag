
precision mediump float;
uniform vec2 u_resolution;

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);

    // PIの値を設定します
    float PI = 3.14159265359;
    vec2 st = gl_FragCoord.xy/u_resolution;

    float offset = .5;
    float curveStrength = .5;
    
    // 渦巻きを作るために余弦値を加える
    // color+= step(offset+cos(st.y*PI)*0.25, st.x);

    color+= 1.0-(step(offset+cos(st.y*PI)*-0.25, st.x));
    color+= (step(offset+cos(st.y*PI)*0.25, st.x));

    gl_FragColor = vec4(1.0-color,1.0);
}