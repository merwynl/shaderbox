
precision mediump float;
uniform vec2 u_resolution;


void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    // 渦巻きを作るために余弦値を加える
    color+= step(.5,st.x);

    gl_FragColor = vec4(color,1.0);
}