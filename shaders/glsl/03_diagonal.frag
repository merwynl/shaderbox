
precision mediump float;
uniform vec2 u_resolution;


void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 st = gl_FragCoord.xy/u_resolution;

    float offset = .5;
    float size = .5;

    // キャンバスを斜めに分割します
    color+= step(offset,(st.x+st.y) * size);

    gl_FragColor = vec4(1.0-color,1.0);
}