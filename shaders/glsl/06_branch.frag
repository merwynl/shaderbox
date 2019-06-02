
precision mediump float;
uniform vec2 u_resolution;
uniform float u_time;  

float stroke(float x, float s, float w){
    float d = step(s, x+w*.5) - step(s, x-w*.5) ;
    return clamp (d, 0., 1.);
}

void main(){
    // 色を黒に設定します
    vec3 color = vec3(0.0, 0.9686, 0.8039);
    vec2 st = gl_FragCoord.xy/u_resolution;

    float offset = 0.5; 
    float size = .05;

    // 対角線を作成します
    float sdf = offset + (st.x - st.y) * .5;
    color += stroke(sdf, .5, size);

    gl_FragColor = vec4(color,1.0);
}