Shader"ShaderCourse/shd_ripples_voffset"
{
    Properties // 入力データ
    {
        _Color_A ("Color A", Color) = (1,1,1,1)
        _Color_B ("Color B", Color) = (1,1,1,1)
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
        _WaveAmp ("Wave Amplitude", Range(0,1)) = 0.1
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
            "Queue" = "Geometry"
        }
        
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
            float _WaveAmp;
            
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

            float GetWave(float2 uv)
            {
                // Create gradial gradiant using radial coordinate
                float2 uvs_centered = uv * 2 - 1;
                float radial_distance = length(uvs_centered);
                float4 circle = (radial_distance.xxx,1);
                
                // return float4(radial_distance.xxx,1);

                // Create ripple wave effect
                float wave = cos((radial_distance - _Time.y * 0.1)* TAU * 5) * 0.5 + 0.5;

                // Invert
                wave *= 1-radial_distance;
                
                
                return wave;
            }
            

            Interpolators vert (meshdata v)
            {
                Interpolators o;

                // float wave = cos((v.uv0.y - _Time.y * 0.1)* TAU * 5);
                // float wave2 = cos((v.uv0.x - _Time.y * 0.1)* TAU * 5);

                // v.vertex.y = wave * wave2 * _WaveAmp;

                v.vertex.y = GetWave(v.uv0) * _WaveAmp;
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                o.uv =  v.uv0; 
                return o;
            }
            
            float4 frag (Interpolators i) : SV_Target
            {
                return GetWave(i.uv);
            }
            ENDCG
        }
    }
}
