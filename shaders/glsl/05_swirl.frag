
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
    float PI = 3.14159265359;;

    float offsetx = cos(st.y*PI)*.05; 
    float offsety = cos(st.x*PI)*.05; 
    float size = .05;

    // 三つの垂直渦を作成
    color+= stroke(st.x, .25 + offsetx, size);
    color+= stroke(st.x, .5 + offsetx, size);
    color+= stroke(st.x, .75 + offsetx, size);

    // 水平スワールを3つ作成します
    color+= stroke(st.y, .25 + offsety, size);
    color+= stroke(st.y, .5 + offsety, size);
    color+= stroke(st.y, .75 + offsety, size);

    gl_FragColor = vec4(color,1.0);
}