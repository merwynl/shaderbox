Shader"ShaderCourse/shd_pattern_manipulation"
{
    Properties // 入力データ
    {
        _Color_A ("Color A", Color) = (1,1,1,1)
        _Color_B ("Color B", Color) = (1,1,1,1)
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #define TAU 6.28318530718

            #include "UnityCG.cginc"

            // Defining the variables specified in the properties
            float4 _Color_A;
            float4 _Color_B;
            float _ColorStart;
            float _ColorEnd;
            
            struct meshdata // always per-mesh data
            {
                float4 vertex : POSITION; // vertex position
                float3 normals : NORMAL;
                float2 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space positions
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                o.uv =  v.uv0; 
                return o;
            }
            
            float4 frag (Interpolators i) : SV_Target
            {
                // Offset based on the vertical. As we increase our value in x, we apply a y value
                // float xOffset = i.uv.y;

                // Zigzag wave
                float xOffset = cos(i.uv.y * TAU * 8 ) * 0.1;
                
                // Backgammon-like pattern
                // float t = cos(i.uv.x * TAU * 5) * 0.5 + xOffset;
                
                // Diagonal pattern - taking the x coordinates and adding a vertical
                float t = cos((i.uv.x + xOffset)* TAU * 5) * 0.5 + 0.5;
                
                return t;
                
            }
            ENDCG
        }
    }
}
